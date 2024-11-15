@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'New Price'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_FLIGHT_NEW_PRICE
  as select from /dmo/travel
{
  key travel_id,
      @Semantics.amount.currencyCode: 'currency_code'
      booking_fee,
      @Semantics.amount.currencyCode: 'currency_code'
      total_price,
      currency_code,
      @Semantics.amount.currencyCode: 'currency_code'
      ZSCALAR_DEMPO( booking_fee => booking_fee, total_price => total_price ) as NewPrice

}
