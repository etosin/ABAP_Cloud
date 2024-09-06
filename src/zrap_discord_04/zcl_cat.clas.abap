CLASS zcl_cat DEFINITION
  PUBLIC
  INHERITING FROM zcl_animal
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS set_data REDEFINITION.
    METHODS eat REDEFINITION.
    METHODS move REDEFINITION.
    METHODS if_oo_adt_classrun~main REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_cat IMPLEMENTATION.

  METHOD set_data.
    name = 'Cat'.
    age  = '6'.
  ENDMETHOD.

  METHOD move.
    distance = '21 km'.
  ENDMETHOD.

  METHOD eat.
    food = 'Vegetables'.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    set_data( ).
    move( ).
    eat( ).

    out->write( |{ 'The animal' } { name } { 'with the age:' } { age } { 'eat' } { food } { 'and walked:' } { distance }| ).

  ENDMETHOD.


ENDCLASS.
