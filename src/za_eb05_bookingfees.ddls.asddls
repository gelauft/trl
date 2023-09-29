@EndUserText.label: 'Booking Fees'
define abstract entity ZA_EB05_BOOKINGFEES
{
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee : /dmo/booking_fee;
    CurrencyCode : /dmo/currency_code;
    
}
