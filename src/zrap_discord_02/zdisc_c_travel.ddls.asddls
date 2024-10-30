extend view entity ZC_DISC_TRAVEL with
{



  @UI: {  lineItem:    [ { position: 60 },
                         { type: #FOR_ACTION, dataAction: 'zzactionExample', label: 'Action Extension' } ],
       identification: [ { position: 60 },
                         { type: #FOR_ACTION, dataAction: 'zzactionExample', label: 'Action Extension' }
                       ] }
  Travel.ZZBonusIdZRP
}
