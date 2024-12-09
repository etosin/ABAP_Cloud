CLASS zcl_bs_demo_job_adt_ntf DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_apj_rt_job_notif_exit.

  PRIVATE SECTION.
    METHODS send_mail
      IMPORTING id_receiver TYPE cl_bcs_mail_message=>ty_address
                id_subject  TYPE string
                id_content  TYPE string.

    METHODS format_json_content
      IMPORTING is_job_details   TYPE cl_apj_rt_api=>ty_job_info
      RETURNING VALUE(rd_result) TYPE string.
ENDCLASS.


CLASS zcl_bs_demo_job_adt_ntf IMPLEMENTATION.
  METHOD if_apj_rt_job_notif_exit~notify_jt_start.
    " Currently not working
  ENDMETHOD.


  METHOD if_apj_rt_job_notif_exit~notify_jt_end.
    TRY.
        data(ls_job_details) = cl_apj_rt_api=>get_job_details( iv_jobname  = is_job_info-job_name
                                                               iv_jobcount = is_job_info-job_count ).
      CATCH cx_apj_rt.
        "handle exception
    ENDTRY.

    SELECT SINGLE FROM I_BusinessUserVH
      FIELDS DefaultEmailAddress
      WHERE UserID = @ls_job_details-job_user
      INTO @DATA(ld_mail).

    DATA(ld_json_formatted) = format_json_content( ls_job_details ).

    send_mail( id_receiver = CONV #( ld_mail )
               id_subject  = |Error in Job: { is_job_info-job_name }|
               id_content  = ld_json_formatted ).
  ENDMETHOD.


  METHOD send_mail.
    TRY.
        DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).

        lo_mail->set_sender( 'BTP-noreply@CONNECT.com' ).
        lo_mail->add_recipient( id_receiver ).

        lo_mail->set_subject( CONV #( id_subject ) ).

        lo_mail->set_main( cl_bcs_mail_textpart=>create_instance( iv_content      = id_content
                                                                  iv_content_type = 'text/html' ) ).

        lo_mail->send( ).

      CATCH cx_bcs_mail INTO DATA(lo_error).
        RAISE SHORTDUMP lo_error.
    ENDTRY.
  ENDMETHOD.


  METHOD format_json_content.
    DATA(ld_content) = /ui2/cl_json=>serialize( data          = is_job_details
                                                format_output = abap_true ).

    rd_result = replace( val = ld_content sub = cl_abap_char_utilities=>cr_lf with = '<br>' occ = 0 ).
  ENDMETHOD.
ENDCLASS.
