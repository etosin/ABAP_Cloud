*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhe_travel DEFINITION INHERITING FROM cl_abap_behavior_event_handler.
  PRIVATE SECTION.

    METHODS booking_canc FOR ENTITY EVENT
       cancelled FOR travel~BookingCancelled.

ENDCLASS.

CLASS lhe_travel IMPLEMENTATION.

  METHOD booking_canc.

    TYPES ty_code_reasons TYPE zrap_disc_codes.

    "close the active modify phase
    cl_abap_tx=>save( ).

    LOOP AT cancelled REFERENCE INTO DATA(lr_cancelled).

      DATA(ls_code_reasons) = VALUE ty_code_reasons( travel_uuid = lr_cancelled->travel_uuid
                                                     reasoncode  = lr_cancelled->ReasonCode
                                                     description = lr_cancelled->Description ).

      INSERT zrap_disc_codes FROM @ls_code_reasons.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
