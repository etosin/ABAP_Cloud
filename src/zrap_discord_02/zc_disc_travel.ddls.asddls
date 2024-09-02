@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Customer Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_DISC_TRAVEL
  provider contract transactional_query
  as projection on ZI_DISC_TRAVEL
{
  key travel_uuid,
      TravelId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DISC_CUSTOMER', element: 'CustomerId'} }]
      @ObjectModel.text.element: ['_Customer.LastName']
      @Search.defaultSearchElement: true
      CustomerId,
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold : 0.8
      @Search.ranking : #HIGH      
      Description,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Booking : redirected to composition child ZC_DISC_BOOKING,
      _Customer
}
