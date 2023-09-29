@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Textelement'
define view entity ZI_EB05_CUSTOMERTEXT 
as select from ZI_EB05_CUSTOMER
{
    key CustomerId,
      concat_with_space(FirstName, LastName, 1) as CustomerName
}
