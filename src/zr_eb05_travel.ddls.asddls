@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel'
define root view entity ZR_EB05_Travel
  as select from zeb05_atravel
  composition [0..*] of ZR_EB05_BOOKING      as _Bookings
  association [1..1] to ZI_EB05_CUSTOMERTEXT as _CustomerText on zeb05_atravel.customer_id = _CustomerText.CustomerId
{
      @EndUserText:{label:'Travel UUID', quickInfo: 'Travel UUID'}
  key travel_uuid   as TravelUuid,
      travel_id     as TravelId,
      agency_id     as AgencyId,
      customer_id   as CustomerId,
      begin_date    as BeginDate,
      end_date      as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee   as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price   as TotalPrice,
      currency_code as CurrencyCode,
      description   as Description,
      status        as Status,

      /* Admin Data */
      @EndUserText:{label:'Created By', quickInfo: 'Created By'}
      @Semantics.user.createdBy: true
      createdby     as Createdby,
      @EndUserText:{label:'Created At', quickInfo: 'Created At'}
      @Semantics.systemDateTime.createdAt: true
      createdat     as Createdat,
      @EndUserText:{label:'Last Changed By', quickInfo: 'Last Changed By'}
      @Semantics.user.lastChangedBy: true
      lastchangedby as Lastchangedby,
      @EndUserText:{label:'Last Changed At', quickInfo: 'Last Changed At'}
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat as Lastchangedat,

      /* Transient Data */
      case status when 'N' then 5
                  when 'B' then 3
                  when 'P' then 2
                  when 'X' then 1
                  else 0
      end           as StatusCriticality,

      case when dats_days_between($session.system_date, begin_date) >=14 then 3
           when dats_days_between($session.system_date, begin_date) >=7 then 2
           when dats_days_between($session.system_date, begin_date) >=0 then 1
           else 0
      end           as BeginDateCriticality,

      /* Associations */
      _Bookings,
      _CustomerText
}
