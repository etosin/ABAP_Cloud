CLASS zcl_amdp_travel_summary_tf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .

    CLASS-METHODS:
      get_travel_summary
        FOR TABLE FUNCTION zi_travel_summary.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_amdp_travel_summary_tf IMPLEMENTATION.
  METHOD get_travel_summary BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                                        OPTIONS READ-ONLY USING zrap_disc_travel zrap_disc_book.

    RETURN select
       t.travel_id,
       t.customer_id,
       t.description,
       count(b.booking_id) AS total_bookings,
       t.total_price,
       t.currency_code
     from
       zrap_disc_travel as t
     left join
       zrap_disc_book as b
     on
       t.travel_uuid = b.travel_uuid
     where
       t.travel_id = :p_travel_id
     GROUP BY
       t.travel_id,
       t.customer_id,
       t.description,
       t.total_price,
       t.currency_code;

  endmethod.

ENDCLASS.
