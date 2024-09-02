CLASS zcl_discord_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_discord_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " step 1 - READ
*    READ ENTITIES OF zi_disc_travel
*      ENTITY travel
*        FROM VALUE #( ( travel_uuid = '2A989BB0FFBBC61319003B7A8E84DC3E' ) )
*      RESULT DATA(travels).

    " step 2 - READ with fields
*    READ ENTITIES OF zi_disc_travel
*      ENTITY travel
*      FIELDS ( TravelId Description )
*        WITH VALUE #( ( travel_uuid = '2A989BB0FFBBC61319003B7A8E84DC3E' ) )
*      RESULT DATA(travels).

    " step 3 - READ with All Fields
*    READ ENTITIES OF zi_disc_travel
*      ENTITY travel
*        ALL FIELDS
*      WITH VALUE #( ( travel_uuid = '2A989BB0FFBBC61319003B7A8E84DC3E' ) )
*      RESULT DATA(travels).

    " step 4 - READ By Association
*    READ ENTITIES OF zi_disc_travel
*      ENTITY travel BY \_Booking
*        ALL FIELDS WITH VALUE #( ( travel_uuid = '2A989BB0FFBBC61319003B7A8E84DC3E' ) )
*      RESULT DATA(bookings).

    " step 5 - Unsuccessful READ
*    READ ENTITIES OF zi_disc_travel
*      ENTITY travel
*        ALL FIELDS WITH VALUE #( ( travel_uuid = '11111111111111111111111111111111' ) )
*      RESULT DATA(travels)
*      FAILED DATA(failed)
*      REPORTED DATA(reported).
*
*    out->write( travels ).
*    out->write( failed ).    " complex structures not supported by the console output
*    out->write( reported ).  " complex structures not supported by the console output

    " step 6 - MODIFY Update
*    MODIFY ENTITIES OF zi_disc_travel
*       ENTITY travel
*         UPDATE
*           SET FIELDS WITH VALUE
*             #( ( travel_uuid = '2A989BB0FFBBC61319003B7A8E84DC3E'
*                  Description = 'Done! :)' ) )
*
*      FAILED DATA(failed)
*      REPORTED DATA(reported).
*
*    " step 6b - Commit Entities
*    COMMIT ENTITIES
*      RESPONSE OF zi_disc_travel
*      FAILED     DATA(failed_commit)
*      REPORTED   DATA(reported_commit).
*
*    out->write( 'Update done' ).

    " step 7 - MODIFY Create
*    MODIFY ENTITIES OF zi_disc_travel
*      ENTITY travel
*        CREATE
*          SET FIELDS WITH VALUE
*            #( ( %cid        = 'MyContentID_1'
*                 TravelId    = '24'
*                 CreatedBy   =  'EMTO'
*                 CreatedAt   = cl_abap_context_info=>get_system_date( )
*                 Description = 'Test RAP' ) )
*
*     MAPPED DATA(mapped)
*     FAILED DATA(failed)
*     REPORTED DATA(reported).
*
*    out->write( mapped-travel ).
*
*    COMMIT ENTITIES
*      RESPONSE OF zi_disc_travel
*      FAILED     DATA(failed_commit)
*      REPORTED   DATA(reported_commit).
*
*    out->write( 'Create done' ).

    " step 8 - MODIFY Delete
    MODIFY ENTITIES OF zi_disc_travel
      ENTITY travel
        DELETE FROM
          VALUE
            #( ( travel_uuid  = 'B66BF843D7E01EDF99C40DD5F2661026' ) )

     FAILED DATA(failed)
     REPORTED DATA(reported).

    COMMIT ENTITIES
      RESPONSE OF zi_disc_travel
      FAILED     DATA(failed_commit)
      REPORTED   DATA(reported_commit).

    out->write( 'Delete done' ).

  ENDMETHOD.
ENDCLASS.
