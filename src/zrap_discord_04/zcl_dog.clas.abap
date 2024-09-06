CLASS zcl_dog DEFINITION
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

CLASS zcl_dog IMPLEMENTATION.

  METHOD set_data.
    name = 'Dog'.
    age  = '2'.
  ENDMETHOD.

  METHOD move.
    distance = '10 km'.
  ENDMETHOD.

  METHOD eat.
    food = 'Meat'.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    set_data( ).
    move( ).
    eat( ).

    out->write( |{ 'The animal' } { name } { 'with the age:' } { age } { 'eat' } { food } { 'and walked:' } { distance }| ).

  ENDMETHOD.


ENDCLASS.
