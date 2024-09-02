@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZC_CDS_TRAVELCOMPOSITION
  as select from ZCDS_TravelComposition
{
  key TravelId,
  key CustomerId,
  description,
  concat_with_space( _Customer.first_name, _Customer.last_name, 1 ) as CustomerName,
  _Customer.country_code as Country
 
  
}
