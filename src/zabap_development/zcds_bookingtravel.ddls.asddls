@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View with Inner and Outer Joins'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_BookingTravel
  as select from    /dmo/booking  as Booking
    inner join      /dmo/travel   as Travel   on Booking.travel_id = Travel.travel_id
    left outer join /dmo/customer as Customer on Travel.customer_id = Customer.customer_id
  association to parent ZCDS_TravelComposition as TravelComposition on  $projection.TravelId   = TravelComposition.TravelId
                                                                    and $projection.CustomerId = TravelComposition.CustomerId

{
  key Booking.travel_id    as TravelId,
  key Customer.customer_id as CustomerId,
      Booking.booking_id   as BookingId,
      Travel.description   as Description,
      Customer.first_name  as FirstName,
      Customer.last_name   as LastName,
      TravelComposition

}
