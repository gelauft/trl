@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status Value Help'
define view entity ZI_EB05_STATUSVH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: '/DMO/STATUS' )
{
      @UI.hidden: true
  key domain_name,
      @UI.hidden: true
  key value_position,
  key language,
      @EndUserText: {label: 'Status', quickInfo: 'Status'}
      value_low as Status,
      @EndUserText: {label: 'Text', quickInfo: 'Text'}
      text      as StatusText
}
