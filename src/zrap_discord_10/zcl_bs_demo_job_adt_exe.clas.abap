CLASS zcl_bs_demo_job_adt_exe DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_apj_dt_exec_object.
    INTERFACES if_apj_rt_exec_object.

  PRIVATE SECTION.
    METHODS log_some_messages
      IMPORTING id_severity TYPE cl_bali_free_text_setter=>ty_severity
      RAISING   cx_bali_runtime
                cx_uuid_error.

ENDCLASS.

CLASS zcl_bs_demo_job_adt_exe IMPLEMENTATION.
  METHOD if_apj_dt_exec_object~get_parameters.
    et_parameter_def = VALUE #( datatype       = 'C'
                                changeable_ind = abap_true
                                ( selname       = 'TEXT'
                                  kind          = if_apj_dt_exec_object=>parameter
                                  param_text    = 'Free text'
                                  length        = 50
                                  lowercase_ind = abap_true
                                  mandatory_ind = abap_true )
                                ( selname    = 'COUNTRY'
                                  kind       = if_apj_dt_exec_object=>select_option
                                  param_text = 'Country'
                                  length     = 3 )
                                ( selname         = 'R_TEXT'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  param_text      = 'Text'
                                  length          = 1
                                  radio_group_ind = abap_true
                                  radio_group_id  = 'R1' )
                                ( selname         = 'R_LAND'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  param_text      = 'Country'
                                  length          = 1
                                  radio_group_ind = abap_true
                                  radio_group_id  = 'R1' )
                                ( selname      = 'TEST'
                                  kind         = if_apj_dt_exec_object=>parameter
                                  param_text   = 'Test'
                                  length       = 1
                                  checkbox_ind = abap_true ) ).

    et_parameter_val = VALUE #( sign   = 'I'
                                option = 'EQ'
                                ( selname = 'TEST' low = abap_true )
                                ( selname = 'R_TEXT' low = abap_false )
                                ( selname = 'R_LAND' low = abap_true ) ).
  ENDMETHOD.


  METHOD if_apj_rt_exec_object~execute.
    DATA ld_text          TYPE c LENGTH 50.
    DATA lt_r_country     TYPE RANGE OF I_CountryText-Country.
    DATA ld_radio_text    TYPE abap_boolean.
    DATA ld_radio_country TYPE abap_boolean.
    DATA ld_test          TYPE abap_boolean.

    "RAISE EXCEPTION NEW cx_apj_rt_content( ).

    LOOP AT it_parameters INTO DATA(ls_parameter).
      CASE ls_parameter-selname.
        WHEN 'TEXT'.
          ld_text = ls_parameter-low.
        WHEN 'COUNTRY'.
          INSERT CORRESPONDING #( ls_parameter ) INTO TABLE lt_r_country.
        WHEN 'R_TEXT'.
          ld_radio_text = ls_parameter-low.
        WHEN 'R_LAND'.
          ld_radio_country = ls_parameter-low.
        WHEN 'TEST'.
          ld_test = ls_parameter-low.
      ENDCASE.
    ENDLOOP.

    TRY.
        DATA(ls_database) = VALUE zbs_dmo_jtrack( identifier = cl_system_uuid=>create_uuid_x16_static( )
                                                  rdate      = cl_abap_context_info=>get_system_date( )
                                                  rtime      = cl_abap_context_info=>get_system_time( )
                                                  test       = ld_test ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.

    CASE abap_true.
      WHEN ld_radio_text.
        ls_database-content = ld_text.

      WHEN ld_radio_country.
        SELECT FROM I_CountryText
          FIELDS CountryName
          WHERE Country IN @lt_r_country
            AND Language = @sy-langu
          INTO TABLE @DATA(lt_names).

        ls_database-content = concat_lines_of( table = lt_names sep = `, ` ).

    ENDCASE.

    INSERT zbs_dmo_jtrack FROM @ls_database.
    COMMIT WORK.

    TRY.
        log_some_messages( if_bali_constants=>c_severity_warning ).
      CATCH cx_bali_runtime cx_uuid_error.
        "handle exception
    ENDTRY.
    TRY.
        log_some_messages( if_bali_constants=>c_severity_error ).
      CATCH cx_bali_runtime cx_uuid_error.
        "handle exception
    ENDTRY.
  ENDMETHOD.

  METHOD log_some_messages.

   DATA lo_free TYPE REF TO if_bali_free_text_setter.

    DATA(lo_log) = cl_bali_log=>create( ).

    DATA(lo_header) = cl_bali_header_setter=>create( object      = 'ZBS_DEMO_JOB_LOG'
                                                     subobject   = 'JOB'
                                                     external_id = cl_system_uuid=>create_uuid_c32_static( ) ).
    lo_log->set_header( lo_header ).

    lo_free = cl_bali_free_text_setter=>create( severity = id_severity
                                                text     = 'This message is free' ).
    lo_log->add_item( lo_free ).

    lo_free = cl_bali_free_text_setter=>create( severity = if_bali_constants=>c_severity_warning
                                                text     = 'This is a warning' ).
    lo_log->add_item( lo_free ).

    lo_free = cl_bali_free_text_setter=>create( severity = if_bali_constants=>c_severity_status
                                                text     = 'This is a success' ).
    lo_log->add_item( lo_free ).

    cl_bali_log_db=>get_instance( )->save_log( log                        = lo_log
                                              assign_to_current_appl_job = abap_true ).

  ENDMETHOD.

ENDCLASS.
