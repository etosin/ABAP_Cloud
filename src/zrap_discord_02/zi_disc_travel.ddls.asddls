@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Travel'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_DISC_TRAVEL
  as select from zrap_disc_travel
  composition [0..*] of ZI_DISC_BOOK     as _Booking
  association [0..1] to ZI_DISC_CUSTOMER as _Customer on $projection.CustomerId = _Customer.CustomerId
{
  key travel_uuid           as travel_uuid,
      travel_id             as TravelId,
      customer_id           as CustomerId,
      description           as Description,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price           as TotalPrice,
      currency_code         as CurrencyCode,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      _Booking,
      _Customer
}
