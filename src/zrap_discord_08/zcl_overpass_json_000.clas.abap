CLASS zcl_overpass_json_000 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_overpass_json_000 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    " Create HTTP client; send request
  TRY.
  DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                           comm_scenario  = 'Z_API_ACCOUNTING_EMTO000'
                           service_id     = 'Z_API_ACCOUNTING_000_REST'

                         ).

      DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).
      DATA(lo_request) = lo_http_client->get_http_request( ).

      lo_request->set_query( query = 'data=[out:json];area["name"="Heidelberg"]["admin_level"="6"];node["amenity"="biergarten"](area);out;' ).

      DATA(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>get ).

      out->write( lo_response->get_text( ) ).
    CATCH cx_root INTO DATA(lx_exception).
      out->write( lx_exception->get_text( ) ).
  ENDTRY.

  ENDMETHOD.

ENDCLASS.
