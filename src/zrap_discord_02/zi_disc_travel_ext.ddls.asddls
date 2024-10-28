@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Extension'
@Metadata.ignorePropagatedAnnotations: true

@AbapCatalog.extensibility: {
    extensible: true,
    elementSuffix: 'ZRP',
    quota: {
        maximumFields: 500,
        maximumBytes: 5000
    },
    dataSources: [ 'Travel' ],
    allowNewDatasources: false
}
define view entity ZI_DISC_TRAVEL_EXT
  as select from zrap_disc_travel as Travel
{
  key travel_uuid as travel_uuid
    

}
