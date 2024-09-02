@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Projection'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_DISC_BOOKING
  as projection on ZI_DISC_BOOK
{
  key BookingUUID,
      TravelUUID,
      @Search.defaultSearchElement: true
      BookingId,
      @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Carrier', element: 'AirlineID' }}]
      @ObjectModel.text.element: ['CarrierName']
      CarrierId,
      CarrierName,
      FlightDate,
      CreatedBy,
      LastChangedBy,
      LocalLastChangedAt,
      /* Associations */
      _Travel : redirected to parent ZC_DISC_TRAVEL
}
