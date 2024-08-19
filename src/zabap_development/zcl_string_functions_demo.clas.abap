CLASS zcl_string_functions_demo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_string_functions_demo IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA:
      result      TYPE i,
      text        TYPE string VALUE `ABAP`,
      substring   TYPE string VALUE `AP`,
      offset      TYPE i VALUE 0,
      characters  TYPE string VALUE `BP`,
      not_in_text TYPE string VALUE `XZY`.

    " Função numofchar: Número de caracteres, incluindo espaços
    result = numofchar( text ).
    out->write( |numofchar: Número de caracteres em `{ text }` = { result }| ).

    " Função count: Número de vezes que substring aparece na string a partir do offset
    result = count( val = text sub = substring off = offset ).
    out->write( |count: Substring `{ substring }` aparece { result } vez(es) em `{ text }` a partir do offset { offset }| ).

    " Função find: Posição do primeiro match da substring na string a partir do offset
    result = find( val = text sub = substring off = offset ).
    out->write( |find: Substring `{ substring }` encontrado em posição { result } em `{ text }` a partir do offset { offset }| ).

    " Função count_any_of: Conta caracteres da string que estão presentes no conjunto dado a partir do offset
    result = count_any_of( val = text sub = characters off = offset ).
    out->write( |count_any_of: `{ characters }` aparece { result } vez(es) (1 vez cada) em `{ text }` a partir do offset { offset }| ).

    " Função find_any_of: Posição do primeiro caractere na string que pertence ao conjunto dado a partir do offset
    result = find_any_of( val = text sub = characters off = offset ).
    out->write( |find_any_of: Primeiro caractere de `{ characters }` encontrado em posição { result } em `{ text }` a partir do offset { offset }| ).

    " Função count_any_not_of: Conta caracteres da string que não estão presentes no conjunt o dado a partir do offset
    result = count_any_not_of( val = text sub = not_in_text off = offset ).
    out->write( |count_any_not_of: Caracteres que não pertencem a `{ not_in_text }` aparecem { result } vez(es) em `{ text }` a partir do offset { offset }| ).

    " Função find_any_not_of: Posição do primeiro caractere na string que não pertence ao conjunto dado a partir do offset
    result = find_any_not_of( val = text sub = not_in_text off = offset ).
    out->write( |find_any_not_of: Primeiro caractere que não pertence a `{ not_in_text }` encontrado em posição { result } em `{ text }` a partir do offset { offset }| ).

  ENDMETHOD.

ENDCLASS.

