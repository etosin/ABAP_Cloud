@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Customer'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_DISC_CUSTOMER
  as select from zrap_disc_custom as Customer
{
  key customer_id as CustomerId,
      first_name  as FirstName,
      last_name   as LastName


}
