CLASS zcl_demo_scalar_function DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .

    CLASS-METHODS:
      execute FOR SCALAR FUNCTION zscalar_dempo.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_demo_scalar_function IMPLEMENTATION.
  METHOD execute BY DATABASE FUNCTION
                 FOR HDB
                 LANGUAGE SQLSCRIPT
                 OPTIONS READ-ONLY.

    result = total_price + booking_fee;

  ENDMETHOD.

ENDCLASS.
