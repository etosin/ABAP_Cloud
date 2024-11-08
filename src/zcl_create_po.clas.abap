CLASS zcl_create_po DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_create_po IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Request para criar a Ordem de Compra
    MODIFY ENTITIES OF I_PurchaseOrderTP_2
        ENTITY PurchaseOrder
        CREATE FROM VALUE #( (
            %cid = 'CID_PO'
            purchaseordertype = 'NB'
            companycode = '3501'
            purchasingorganization = '3501'
            purchasinggroup = '001'
            supplier = '1000000'
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
                material = '30'
                plant = '3517'
                orderquantity = 4
                purchaseorderitem = '00010'
                netpriceamount = 12
                %control-material = cl_abap_behv=>flag_changed
                %control-manufacturermaterial = cl_abap_behv=>flag_changed
                %control-plant = cl_abap_behv=>flag_changed
                %control-orderquantity = cl_abap_behv=>flag_changed
                %control-purchaseorderitem = cl_abap_behv=>flag_changed
                %control-netpriceamount = cl_abap_behv=>flag_changed
            ) )


) )

        MAPPED DATA(lt_create_mapped)
        FAILED DATA(lt_create_failed)
        REPORTED DATA(lt_create_reported).

    " Commit da transação
    COMMIT ENTITIES BEGIN
      RESPONSE OF I_PurchaseOrderTP_2
      FAILED DATA(commit_failed)
      REPORTED DATA(commit_reported).

    LOOP AT lt_create_mapped-PurchaseOrder ASSIGNING FIELD-SYMBOL(<keys_header>).
      CONVERT KEY OF I_PurchaseOrderTP_2
      FROM <keys_header>-%pid
      TO <keys_header>-%key.
    ENDLOOP.

    LOOP AT lt_create_mapped-PurchaseOrderItem ASSIGNING FIELD-SYMBOL(<keys_item>).
      CONVERT KEY OF I_PurchaseOrderItemTP_2
      FROM <keys_item>-%pid
      TO <keys_item>-%key.
    ENDLOOP.

    COMMIT ENTITIES END.

  ENDMETHOD.
ENDCLASS.
