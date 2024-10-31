extend view entity ZC_DISC_TRAVEL with
{

  @UI.facet: [ { id:            'Review',
               purpose:         #STANDARD,
               type:            #IDENTIFICATION_REFERENCE,
               label:           'Review',
               position:        20,
               targetElement:   'ZZ_RatingZRP'} ]

  Travel.ZZ_RatingZRP : redirected to composition child ZC_DISC_RATING
}
