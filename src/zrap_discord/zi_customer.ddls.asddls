@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer interface veiw'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_customer
  as select from zismo_kna1
{
  key cust_id      as CustId,
      cust_name    as CustName,
      cust_city    as CustCity,
      last_changed as lastchanged,
       @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_at as lastat
}
