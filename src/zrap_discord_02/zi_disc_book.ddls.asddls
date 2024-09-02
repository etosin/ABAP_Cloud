@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_DISC_BOOK
  as select from zrap_disc_book as booking
  association        to parent ZI_DISC_TRAVEL as _Travel  on $projection.TravelUUID = _Travel.travel_uuid
  association [0..1] to /dmo/carrier          as _Carrier on $projection.CarrierId = _Carrier.carrier_id
{
  key booking_uuid          as BookingUUID,
      travel_uuid           as TravelUUID,
      booking_id            as BookingId,
      carrier_id            as CarrierId,
      _Carrier.name         as CarrierName,
      flight_date           as FlightDate,
      created_by            as CreatedBy,
      last_changed_by       as LastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      _Travel
}
