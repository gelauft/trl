@EndUserText.label: 'travel'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_EB05_Travel
  as projection on ZR_EB05_Travel
{
  key TravelUuid,
      TravelId,
      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,
      CurrencyCode,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Description,
      Status,
      
      /* Admin Data */
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      
      /* Transient Data */
      StatusCriticality,
      BeginDateCriticality,
      
      /* Associations */
      _Bookings : redirected to composition child ZC_EB05_BOOKING
      
}
