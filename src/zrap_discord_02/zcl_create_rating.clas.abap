CLASS zcl_create_rating DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_create_rating IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: ls_rating TYPE zrap_review.

    SELECT *
    FROM zrap_disc_travel
    INTO TABLE @DATA(lt_travel).

    LOOP AT lt_travel ASSIGNING FIELD-SYMBOL(<fs_travel>).

      ls_rating-client = <fs_travel>-client.
      ls_rating-travel_uuid = <fs_travel>-travel_uuid.
      ls_rating-free_text_comment = 'Travel OK'.

      DATA(lv_mod) = sy-tabix MOD 2.

      IF lv_mod = 0.

        ls_rating-rating = 3.

      ELSE.

        ls_rating-rating = 5.

      ENDIF.

      INSERT zrap_review FROM @ls_rating.

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
