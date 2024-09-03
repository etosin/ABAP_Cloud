CLASS zcl_travel_summary_get DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_travel_summary_get IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    zcl_amdp_travel_summary=>get_travel_summary(
      EXPORTING
        iv_travel_id      = '00000011'
      IMPORTING
        et_travel_summary = DATA(lt_travel) ).

    out->write( lt_travel ).

  ENDMETHOD.
ENDCLASS.
