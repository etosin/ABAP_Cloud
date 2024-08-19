CLASS zcl_tosin_hello_world_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tosin_hello_world_03 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'Hello World!' ).

  ENDMETHOD.
ENDCLASS.
