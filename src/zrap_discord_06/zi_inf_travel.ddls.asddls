@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travael Information'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_INF_TRAVEL  
  as select from zrap_inf_travel as InfTravel
{
  key travel_uuid as TravelUuid,
      travel_id   as TravelId,    
      description as Description
}
