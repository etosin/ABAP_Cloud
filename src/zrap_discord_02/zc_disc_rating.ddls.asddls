@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Rating Projection'
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'Rating' ]
define view entity ZC_DISC_RATING
  as projection on ZI_DISC_RATING
{
  key TravelUuid,
      Rating,
      FreeTextComment,
      /* Associations */
      _Travel : redirected to parent ZC_DISC_TRAVEL
}
