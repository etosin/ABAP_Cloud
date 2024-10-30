CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS zzactionExample FOR MODIFY
      IMPORTING keys FOR ACTION Travel~zzactionExample.
    METHODS zz_check_bonus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~zz_check_bonus.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD zzactionExample.

    "Do anything

  ENDMETHOD.

  METHOD zz_check_bonus.

    CONSTANTS: lc_numbers(13) VALUE ' 1234567890.'.

    " Read relevant travel instance data
    READ ENTITIES OF zi_disc_travel IN LOCAL MODE
      ENTITY Travel
        FIELDS ( ZZBonusIdZRP ) WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    " Raise msg for non existing and initial customerID
    LOOP AT travels INTO DATA(travel).

      IF NOT travel-ZZBonusIdZRP CO lc_numbers.

        " Clear state messages that might exist
        APPEND VALUE #(  %tky        = travel-%tky
                         %state_area = 'VALIDATE_BONUS' )
          TO reported-travel.

        APPEND VALUE #(  %tky = travel-%tky ) TO failed-travel.

        APPEND VALUE #(  %tky        = travel-%tky
                         %state_area = 'VALIDATE_BONUS'
                         %msg        = NEW zcm_rap_discord(
                                          severity   = if_abap_behv_message=>severity-error
                                          textid     = zcm_rap_discord=>bonus_id_error
                                          zzbonusid = travel-ZZBonusIdZRP )
                         %element-ZZBonusIdZRP = if_abap_behv=>mk-on )
          TO reported-travel.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
