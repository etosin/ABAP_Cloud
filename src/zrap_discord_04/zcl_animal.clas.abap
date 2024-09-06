CLASS zcl_animal DEFINITION
 PUBLIC ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
    METHODS:
      set_data,
      eat,
      move,
      constructor.

  PROTECTED SECTION.
    DATA:
      name     TYPE string,
      age      TYPE i,
      food     TYPE string,
      distance TYPE string.
ENDCLASS.

CLASS zcl_animal IMPLEMENTATION.
  METHOD constructor.
    name     = 'Unknown'.
    age      = 0.
    food     = 'Any food'.
    distance = 0.
  ENDMETHOD.

  METHOD set_data.
  ENDMETHOD.

  METHOD eat.
  ENDMETHOD.

  METHOD move.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    out->write( |{ 'The animal' } { name } { 'with the age:' } { age } { 'eat' } { food } { 'and walked:' } { distance }| ).

  ENDMETHOD.



ENDCLASS.
