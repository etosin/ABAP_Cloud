@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS with Associations Path Expressions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_TravelCustomer
  as select from /dmo/travel as Travel
  association [1..1] to /dmo/customer as _Customer on Travel.customer_id = _Customer.customer_id
{

  key Travel.travel_id,
  key Travel.customer_id,
      Travel.description,
      _Customer
}
