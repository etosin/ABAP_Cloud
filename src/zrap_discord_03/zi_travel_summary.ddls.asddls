@EndUserText.label: 'Travel Summary'
@ClientHandling.type: #CLIENT_INDEPENDENT
@ClientHandling.algorithm: #NONE
define table function ZI_TRAVEL_SUMMARY
  with parameters
    p_travel_id : /dmo/travel_id
returns
{
  travel_id      : /dmo/travel_id;
  customer_id    : /dmo/customer_id;
  description    : /dmo/description;
  total_bookings : abap.int4;
  total_price    : /dmo/total_price;
  currency_code  : /dmo/currency_code;

}
implemented by method
  zcl_amdp_travel_summary_tf=>get_travel_summary;