CLASS zcl_discord_gen_data_001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_discord_gen_data_001 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DELETE FROM zrap_disc_travel.
    DELETE FROM zrap_disc_custom.
    DELETE FROM zrap_disc_book.

    INSERT zrap_disc_travel FROM (

     SELECT
      FROM /dmo/travel AS travel
      FIELDS
      uuid(  )      AS travel_uuid           ,
      travel~travel_id,
      travel~customer_id,
      travel~description,
      travel~total_price,
      travel~currency_code,
      createdby     AS created_by            ,
         createdat     AS created_at            ,
         lastchangedby AS last_changed_by       ,
         lastchangedat AS last_changed_at       ,
         lastchangedat AS local_last_changed_at
    ).

    COMMIT WORK.

    INSERT zrap_disc_custom FROM (

     SELECT
      FROM /dmo/customer AS customer
      FIELDS
      customer~customer_id,
      customer~first_name,
      customer~last_name
     ).

    COMMIT WORK.

    INSERT zrap_disc_book FROM (

   SELECT
    FROM /dmo/booking AS booking
     JOIN zrap_disc_travel AS z
         ON   booking~travel_id = z~travel_id
    FIELDS
    uuid( )                 AS booking_uuid          ,
    z~travel_uuid           AS travel_uuid ,
    booking~booking_id,
    booking~carrier_id,
    booking~flight_date,
    z~created_by            AS created_by            ,
         z~last_changed_by       AS last_changed_by       ,
         z~last_changed_at       AS local_last_changed_by

   ).

    COMMIT WORK.
    out->write( |[Discord] Demo data generated for all tables. | ).

  ENDMETHOD.
ENDCLASS.
