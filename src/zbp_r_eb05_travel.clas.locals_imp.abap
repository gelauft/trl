CLASS lhc_travel DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS cancel_booking FOR MODIFY
      IMPORTING keys FOR ACTION travel~cancel_booking.

    METHODS show_test_message FOR MODIFY
      IMPORTING keys FOR ACTION travel~show_test_message.
    METHODS maintain_booking_fees FOR MODIFY
      IMPORTING keys FOR ACTION travel~maintain_booking_fees RESULT result.

ENDCLASS.

CLASS lhc_travel IMPLEMENTATION.

  METHOD get_instance_authorizations.

  ENDMETHOD.
  METHOD show_test_message.
    DATA(message) = NEW zcm_eb05_travel(

        i_textid = zcm_eb05_travel=>test_message

        i_severity = if_abap_behv_message=>severity-error

        i_user_name = sy-uname ).

    APPEND message TO reported-%other.
  ENDMETHOD.

  METHOD cancel_booking.
    " Ausgewählten Daten lesen
    READ ENTITY IN LOCAL MODE zr_eb05_travel
        FIELDS ( TravelUuid Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).

    "Über die Daten interieren



    LOOP AT travels REFERENCE INTO DATA(travel).
      IF travel->Status = 'X'.
        DATA(message) = NEW zcm_eb05_travel(

      i_textid = zcm_eb05_travel=>travel_canceled_successfuly
      i_severity = if_abap_behv_message=>severity-error
      i_travel = travel->Description ).

        APPEND VALUE #( %tky = travel->%tky %msg = message ) TO reported-travel.
        APPEND VALUE #( %tky = travel->%tky ) TO failed-travel.

      ENDIF.

      travel->Status = 'X'.

      message = NEW zcm_eb05_travel(

      i_textid = zcm_eb05_travel=>travel_canceled_successfuly
      i_severity = if_abap_behv_message=>severity-success
      i_travel = travel->Description ).

      APPEND VALUE #( %tky = travel->%tky %msg = message ) TO reported-travel.

      MODIFY ENTITY IN LOCAL MODE ZR_EB05_Travel
      UPDATE FIELDS ( Status )
      WITH VALUE #( ( %tky = travel->%tky Status = travel->Status ) ).

    ENDLOOP.
  ENDMETHOD.

  METHOD maintain_booking_fees.
    READ ENTITY IN LOCAL MODE zr_eb05_travel
        FIELDS ( TravelUuid )
        WITH CORRESPONDING #( keys )
        RESULT DATA(travels).

    LOOP AT travels REFERENCE INTO DATA(travel).
      travel->BookingFee = keys[ sy-tabix ]-%param-BookingFee.
      travel->CurrencyCode = keys[ sy-tabix ]-%param-CurrencyCode.

      MODIFY ENTITY IN LOCAL MODE zr_eb05_travel
        UPDATE FIELDS ( BookingFee CurrencyCode )
        WITH VALUE #( ( %tky = travel->%tky
        BookingFee = travel->BookingFee
        CurrencyCode = travel->CurrencyCode ) ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
