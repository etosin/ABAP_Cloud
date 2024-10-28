@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Customer Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true

@AbapCatalog.extensibility: {
    extensible: true,
    elementSuffix: 'ZRP',
    quota: {
        maximumFields: 500,
        maximumBytes: 5000
    },
    dataSources: [ 'Travel' ],
    allowNewCompositions: true
}
@UI: {
  headerInfo: { typeName: 'Travel',
                typeNamePlural: 'Travels',
                title: { type: #STANDARD, label: 'Travel', value: 'TravelId' } },
  presentationVariant: [{ sortOrder: [{ by: 'TravelId', direction:  #DESC }] }] }
define root view entity ZC_DISC_TRAVEL
  provider contract transactional_query
  as projection on ZI_DISC_TRAVEL as Travel
{

      @UI.facet: [ { id:            'Travel',
                   purpose:         #STANDARD,
                   type:            #IDENTIFICATION_REFERENCE,
                   label:           'Travel',
                   position:        10 },
                 { id:              'Booking',
                   purpose:         #STANDARD,
                   type:            #LINEITEM_REFERENCE,
                   label:           'Booking',
                   position:        20,
                   targetElement:   '_Booking'} ]


      @UI:{ identification: [{ position: 1, label: 'Travel UUID' }] }
  key travel_uuid,

      @UI: {  lineItem:       [ { position: 10 } ],
            identification: [ { position: 10 } ],
            selectionField: [ { position: 10 } ] }
      TravelId,

      @UI: {  lineItem:       [ { position: 20 } ],
       identification: [ { position: 20 } ],
       selectionField: [ { position: 20 } ] }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_DISC_CUSTOMER', element: 'CustomerId'} }]
      @ObjectModel.text.element: ['_Customer.LastName']
      @Search.defaultSearchElement: true
      CustomerId,

      @UI: {  lineItem:       [ { position: 30 },
                           { type: #FOR_ACTION, dataAction: 'acceptTravel', label: 'Accept Travel' },
                           { type: #FOR_ACTION, dataAction: 'rejectTravel', label: 'Reject Travel' }
                         ],
         identification: [ { position: 30 },
                           { type: #FOR_ACTION, dataAction: 'acceptTravel', label: 'Accept Travel' },
                           { type: #FOR_ACTION, dataAction: 'rejectTravel', label: 'Reject Travel' }
                         ] }
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold : 0.8
      @Search.ranking : #HIGH
      Description,

      @UI: {  lineItem:       [ { position: 40 } ],
       identification: [ { position: 40 } ] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,

      @UI: {
      lineItem: [ { position: 40, label: 'Currency Code', importance: #HIGH } ],
      identification: [ { position: 40, label: 'Currency Code', importance: #HIGH } ]
      }
      CurrencyCode,

      @UI.hidden: true
      CreatedBy,

      @UI.hidden: true
      CreatedAt,

      @UI.hidden: true
      LastChangedBy,

      @UI.hidden: true
      LastChangedAt,

      @UI.hidden: true
      LocalLastChangedAt,
      /* Associations */
      _Booking : redirected to composition child ZC_DISC_BOOKING,
      _Customer
}
