CLASS zcl_auth_example DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_auth_example IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT *
     FROM zi_customer
     INTO TABLE @DATA(lt_customers).

    LOOP AT lt_customers ASSIGNING FIELD-SYMBOL(<fs_customers>).

      AUTHORITY-CHECK OBJECT '/DMO/TRVL'
       ID 'CNTRY' FIELD 'US'
       ID 'ACTVT' FIELD '03'.

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
