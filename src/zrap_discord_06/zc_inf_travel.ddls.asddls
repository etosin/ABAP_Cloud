@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Information'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_INF_TRAVEL
  provider contract transactional_query
  as projection on ZI_INF_TRAVEL

{
  key TravelUuid,
      TravelId,     
      Description

}
