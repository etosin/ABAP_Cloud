@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View with Compositions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_TravelComposition
  as select from ZCDS_TravelCustomer as Travel
  composition [1..*] of ZCDS_BookingTravel as _Bookings
{

  key Travel.travel_id   as TravelId,
  key Travel.customer_id as CustomerId,
      Travel.description,
      _Bookings,
      _Customer
}
