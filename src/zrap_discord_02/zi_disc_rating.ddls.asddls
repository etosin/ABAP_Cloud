@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Rating'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DISC_RATING
  as select from zrap_review as Review
  association to parent ZI_DISC_TRAVEL as _Travel on $projection.TravelUuid = _Travel.travel_uuid
{
  key Review.travel_uuid       as TravelUuid,
      Review.rating            as Rating,
      Review.free_text_comment as FreeTextComment,
      _Travel
}
