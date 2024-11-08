CLASS lhc_ZI_INF_TRAVEL DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR InfTravel RESULT result.
    METHODS calculatetravelid FOR DETERMINE ON SAVE
      IMPORTING keys FOR InfTravel~calculatetravelid.

ENDCLASS.

CLASS lhc_ZI_INF_TRAVEL IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD calculateTravelID.

    " check if TravelID is already filled
    READ ENTITIES OF zi_inf_travel IN LOCAL MODE
      ENTITY InfTravel
        FIELDS ( TravelID ) WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    " remove lines where TravelID is already filled.
    DELETE travels WHERE TravelID IS NOT INITIAL.

    " anything left ?
    CHECK travels IS NOT INITIAL.

    " Select max travel ID
    SELECT SINGLE
        FROM  zi_inf_travel
        FIELDS MAX( TravelId ) AS travelID
        INTO @DATA(max_travelid).

    " Set the travel ID
    MODIFY ENTITIES OF zi_inf_travel IN LOCAL MODE
ENTITY InfTravel
  UPDATE
    FROM VALUE #( FOR travel IN travels INDEX INTO i (
      %tky              = travel-%tky
      TravelID          = max_travelid + i
      %control-TravelID = if_abap_behv=>mk-on ) )
REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_INF_TRAVEL DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_INF_TRAVEL IMPLEMENTATION.

  METHOD save_modified.

    DATA ls_inf_travel TYPE STRUCTURE FOR CREATE zi_inf_travel.

    IF create IS NOT INITIAL.

      LOOP AT create-inftravel ASSIGNING FIELD-SYMBOL(<fs_inftravel>).

        ls_inf_travel = VALUE #( TravelUuid  = <fs_inftravel>-TravelUuid
                                 TravelId    = <fs_inftravel>-TravelId
                                 Description = <fs_inftravel>-Description ).

        INSERT zrap_inf_travel FROM @ls_inf_travel MAPPING FROM ENTITY.

      ENDLOOP.


    ENDIF.

    IF update IS NOT INITIAL.

      "Do something

    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
