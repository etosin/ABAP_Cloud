CLASS zcl_luw_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_luw_test IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(ls_po_data) = VALUE zcl_bgpf=>ts_po_data(
     purchaseordertype = 'NB'
     companycode = 'NL20'
     purchasingorganization = 'NL20'
     purchasinggroup = 'INT'
     supplier = 'ES10IC'
     material = '000000005001800763'
     plant = 'ES1D'
     orderquantity = 1
     netpriceamount = 12
   ).

    DATA(lo_operation) = NEW zcl_bgpf( ls_po_data ).

    TRY.

        DATA(lo_process) = cl_bgmc_process_factory=>get_default(  )->create(  ).

        lo_process->set_name( 'bgPF RAP' )->set_operation(  lo_operation ).

        lo_process->save_for_execution( ).

        COMMIT WORK.

      CATCH cx_bgmc.

        RETURN.
    ENDTRY.


  ENDMETHOD.

ENDCLASS.
