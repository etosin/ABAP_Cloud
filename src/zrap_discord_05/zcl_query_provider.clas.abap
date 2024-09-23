CLASS zcl_query_provider DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .

    TYPES gty_travel TYPE RANGE OF zi_disc_travel.
    TYPES gty_travel_s TYPE LINE OF gty_travel.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_query_provider IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA lt_result          TYPE STANDARD TABLE OF zi_custom_entity.
    DATA lv_orderby_string  TYPE string.

    TRY.

        IF io_request->is_data_requested( ).

          TRY.
              " get and add filter
              DATA(ls_filter_cond) = io_request->get_filter( )->get_as_sql_string( ).

            CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
              RETURN.
          ENDTRY.

          DATA(lv_top)     = COND #( WHEN io_request->get_paging( )->get_page_size( ) > 0 THEN  io_request->get_paging( )->get_page_size( ) ELSE 1 ).
          DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).

          SELECT
           FROM zi_disc_travel
           FIELDS TravelId,
                  CustomerId,
                  Description,
                  CreatedBy,
                  CreatedAt
              WHERE (ls_filter_cond)
               ORDER BY TravelId
              INTO TABLE @lt_result
              UP TO @lv_top ROWS
                OFFSET @lv_skip.

          io_response->set_total_number_of_records( lines( lt_result ) ).
          io_response->set_data( lt_result ).

        ENDIF.

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).

        DATA(exception_message) = cl_message_helper=>get_latest_t100_exception( lx_gateway )->if_message~get_longtext( ).

    ENDTRY.
  ENDMETHOD.
ENDCLASS.
