CLASS zcl_bgpf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_serializable_object .
    INTERFACES if_bgmc_operation .
    INTERFACES if_bgmc_op_single .


    TYPES: BEGIN OF ts_po_data,
             purchaseordertype      TYPE I_PurchaseOrderTP_2-purchaseordertype,
             companycode            TYPE I_PurchaseOrderTP_2-companycode,
             purchasingorganization TYPE I_PurchaseOrderTP_2-purchasingorganization,
             purchasinggroup        TYPE I_PurchaseOrderTP_2-purchasinggroup,
             supplier               TYPE I_PurchaseOrderTP_2-supplier,
             material               TYPE I_PurchaseOrderItemTP_2-material,
             plant                  TYPE I_PurchaseOrderItemTP_2-plant,
             orderquantity          TYPE I_PurchaseOrderItemTP_2-orderquantity,
             netpriceamount         TYPE I_PurchaseOrderItemTP_2-netpriceamount,
           END OF ts_po_data.

    METHODS constructor
      IMPORTING
        is_po_data TYPE ts_po_data.

  PRIVATE SECTION.
    DATA ms_po_data  TYPE ts_po_data.
    DATA: ms_mapped   TYPE RESPONSE FOR MAPPED I_PurchaseOrderTP_2,
          ms_failed   TYPE RESPONSE FOR FAILED I_PurchaseOrderTP_2,
          ms_reported TYPE RESPONSE FOR REPORTED I_PurchaseOrderTP_2.

    METHODS create_purchase_order
      RAISING cx_bgmc_operation.

ENDCLASS.

CLASS zcl_bgpf IMPLEMENTATION.
  METHOD constructor.
    ms_po_data = is_po_data.
  ENDMETHOD.

  METHOD if_bgmc_op_single~execute.
    TRY.
        " Cria a ordem de compra
        create_purchase_order( ).

        " Executa o commit de forma segura
        cl_abap_tx=>save( ).

      CATCH cx_bgmc_operation INTO DATA(lo_error).
        RAISE EXCEPTION lo_error.
    ENDTRY.
  ENDMETHOD.

  METHOD create_purchase_order.
    WAIT UP TO 10 SECONDS.

    MODIFY ENTITIES OF I_PurchaseOrderTP_2
      ENTITY PurchaseOrder
      CREATE FROM VALUE #( (
          %cid = 'CID_PO'
          purchaseordertype = ms_po_data-purchaseordertype
          companycode = ms_po_data-companycode
          purchasingorganization = ms_po_data-purchasingorganization
          purchasinggroup = ms_po_data-purchasinggroup
          supplier = ms_po_data-supplier
          %control-purchaseordertype = cl_abap_behv=>flag_changed
          %control-companycode = cl_abap_behv=>flag_changed
          %control-purchasingorganization = cl_abap_behv=>flag_changed
          %control-purchasinggroup = cl_abap_behv=>flag_changed
          %control-supplier = cl_abap_behv=>flag_changed
      ) )
      ENTITY PurchaseOrder
      CREATE BY \_PurchaseOrderItem
      FROM VALUE #( (
          %cid_ref = 'CID_PO'
          %target = VALUE #( (
              %cid = 'CID_PO_ITEM'
              material = ms_po_data-material
              plant = ms_po_data-plant
              orderquantity = ms_po_data-orderquantity
              purchaseorderitem = '00010'
              netpriceamount = ms_po_data-netpriceamount
              %control-material = cl_abap_behv=>flag_changed
              %control-plant = cl_abap_behv=>flag_changed
              %control-orderquantity = cl_abap_behv=>flag_changed
              %control-purchaseorderitem = cl_abap_behv=>flag_changed
              %control-netpriceamount = cl_abap_behv=>flag_changed
          ) )
      ) )
      MAPPED ms_mapped
      FAILED ms_failed
      REPORTED ms_reported.

    " Commit da transação
    COMMIT ENTITIES BEGIN
      RESPONSE OF I_PurchaseOrderTP_2
      FAILED DATA(commit_failed)
      REPORTED DATA(commit_reported).

    LOOP AT ms_mapped-purchaseorder ASSIGNING FIELD-SYMBOL(<keys_header>).
      CONVERT KEY OF I_PurchaseOrderTP_2
        FROM <keys_header>-%pid
        TO <keys_header>-%key.
    ENDLOOP.

    LOOP AT ms_mapped-purchaseorderitem ASSIGNING FIELD-SYMBOL(<keys_item>).
      CONVERT KEY OF I_PurchaseOrderItemTP_2
        FROM <keys_item>-%pid
        TO <keys_item>-%key.
    ENDLOOP.

    COMMIT ENTITIES END.
  ENDMETHOD.

ENDCLASS.
