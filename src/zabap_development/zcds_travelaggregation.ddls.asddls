@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS with Aggr, Parameters'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_TravelAggregation
  with parameters
    p_country : land1
  as select from /dmo/travel   as Travel
    inner join   /dmo/customer as Customer on Travel.customer_id = Customer.customer_id
{
  count( distinct Travel.travel_id )                              as num_travels,
  Customer.customer_id,
  Customer.country_code,
  concat_with_space( Customer.first_name, Customer.last_name, 1 ) as Full_name,
  substring( Customer.first_name, 1, 5 )                          as Name_start

}
where
  Customer.country_code = $parameters.p_country
group by
  Customer.customer_id,
  Customer.country_code,
  Customer.first_name,
  Customer.last_name
