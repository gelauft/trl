@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Value Help'
define view entity ZI_EB05_CUSTOMERVH
  as select from ZI_NK05_Customer
{
  key CustomerId,
      FirstName,
      LastName,
      Title,
      Street,
      PostalCode,
      City,
      CountryCode
}
