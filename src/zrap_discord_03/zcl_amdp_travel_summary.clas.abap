CLASS zcl_amdp_travel_summary DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .

    TYPES:
      BEGIN OF ty_travel_summary,
        travelid       TYPE /dmo/travel_id,
        customerid     TYPE /dmo/customer_id,
        description    TYPE /dmo/description,
        total_bookings TYPE i,
        totalprice     TYPE /dmo/total_price,
        currencycode   TYPE /dmo/currency_code,
      END OF ty_travel_summary.

    TYPES gty_travel_summart TYPE STANDARD TABLE OF ty_travel_summary WITH EMPTY KEY.

    CLASS-METHODS:
      get_travel_summary
        AMDP OPTIONS READ-ONLY
        CDS SESSION CLIENT DEPENDENT
        IMPORTING
          VALUE(iv_travel_id)      TYPE zrap_disc_travel-travel_id
        EXPORTING
          VALUE(et_travel_summary) TYPE gty_travel_summart.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_amdp_travel_summary IMPLEMENTATION.
  METHOD get_travel_summary BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT
                                        OPTIONS READ-ONLY USING zi_disc_travel zi_disc_book.

    et_travel_summary =
       SELECT
         t.travelid,
         t.customerid,
         t.description,
         COUNT(b.bookingid) AS total_bookings,
         t.totalprice,
         t.currencycode
       FROM
         ZI_DISC_TRAVEL AS t
       LEFT JOIN
         ZI_DISC_BOOK AS b
       ON
         t.travel_uuid = b.traveluuid
       WHERE
         t.travelid = :iv_travel_id
       GROUP BY
         t.travelid,
         t.customerid,
         t.description,
         t.totalprice,
         t.currencycode;

  ENDMETHOD.

ENDCLASS.
