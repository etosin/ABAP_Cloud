CLASS zcl_bs_demo_poc_job_cre DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_bs_demo_poc_job_cre IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    CONSTANTS lc_transport TYPE cl_apj_dt_create_content=>ty_transport_request VALUE 'NP4K900011'.
    CONSTANTS lc_package   TYPE cl_apj_dt_create_content=>ty_package           VALUE 'ZRAP_DISCORD_10'.

    TRY.
        DATA(lo_dt) = cl_apj_dt_create_content=>get_instance( ).

        lo_dt->create_job_cat_entry( iv_catalog_name       = 'ZBS_DEMO_POC_JOB_CATAPI'
                                     iv_class_name         = 'ZCL_BS_DEMO_POC_JOB_EXE'
                                     iv_text               = 'DEMO: Job API'
                                     iv_catalog_entry_type = cl_apj_dt_create_content=>class_based
                                     iv_transport_request  = lc_transport
                                     iv_package            = lc_package ).
        out->write( |Job catalog entry created successfully| ).

      CATCH cx_apj_dt_content INTO DATA(lo_apj_dt_content).
        out->write( |Creation of job catalog entry failed: { lo_apj_dt_content->get_text( ) }| ).
    ENDTRY.

    TRY.
        NEW zcl_bs_demo_job_adt_exe( )->if_apj_dt_exec_object~get_parameters(
          IMPORTING et_parameter_val = DATA(lt_parameters) ).

        IF 1 = 1.
          lo_dt->create_job_template_entry( iv_template_name     = 'ZBS_DEMO_POC_JOB_TEMPAPI'
                                            iv_catalog_name      = 'ZBS_DEMO_POC_JOB_CATAPI'
                                            iv_text              = 'DEMO: Job API'
                                            it_parameters        = lt_parameters
                                            iv_transport_request = lc_transport
                                            iv_package           = lc_package ).
          out->write( |Job template created successfully| ).

        ELSE.
          lo_dt->delete_job_template_entry( iv_template_name     = 'ZBS_DEMO_JOB_TEMPLATE_DEFAULT'
                                            iv_transport_request = lc_transport ).
          out->write( |Job template deleted successfully| ).

        ENDIF.

      CATCH cx_apj_dt_content INTO lo_apj_dt_content.
        out->write( |Creation of job template failed: { lo_apj_dt_content->get_text( ) }| ).
        RETURN.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
