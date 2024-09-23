@EndUserText.label: 'Custom Entity Example'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_QUERY_PROVIDER'
define custom entity ZI_CUSTOM_ENTITY
{
      @UI.facet   : [
                {
                  id     :  'Travel',
                  purpose:  #STANDARD,
                  type   :  #IDENTIFICATION_REFERENCE,
                  label  :  'Travel',
                  position  : 10 }
              ]

      @UI         : { identification: [{ position: 1, label: 'Travel ID' }] }
  key travelid    : abap.numc( 8 );

      @UI         : {

       lineItem   : [{ label: 'Customer ID', position: 20, importance: #HIGH}],
       identification: [{ label: 'Customer ID', position: 20} ],
       selectionField: [ { position: 20  } ] }
      @EndUserText.label: 'Customer ID' 
      customer_id : abap.numc( 6 );

      @UI         : {
      lineItem    : [{ label: 'Description', position: 30}],
      identification: [{label: 'Description', position: 30} ],
      selectionField: [ { position: 30  } ] }
      Description : abap.sstring( 1024 );

      @UI         : {
      identification: [{ label: 'Created by', position: 40}] }
      CreatedBy   : abap.char( 12 );

      @UI         : {
      identification: [{ label: 'Created at', position: 50}] }
      CreatedAt   : abap.dec( 21, 7 );

}
