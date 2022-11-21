# README

* Ruby version `3.1.2`

* Rails version `7.0.4`

* How to run the test suite
  * Run `bundle exec rspec`
  
* Services
    * `AirBnbParsingService` - transforms request params from `POST /reservations` if the params keys matches expected keys for AirBnb data.
    * `BookingDotComParsingService` - transforms request params from `POST /reservations` if the params keys matches expected keys for Booking.com data.
    * `ReservationParsingService` 
      - transforms request params depending on which data format they match. If they don't match any from AirBnb and Booking.com, it raises an error.
      - creates/updates Reservations based on whether the reservation code exists or not.
  
* Endpoints:
  * `POST /reservations`
    - creates a new reservation or updates an existing reservation
    - 🚨 currently PUBLIC and should not be 🚨
    - only accepts data from AirBnb and Booking.com. If the param keys do not match from both options, it will raise an error and data will be lost.
    * Sample Payloads accepted by the endpoint 

      - AirBnb (Payload 2)
    ```
    {
        "reservation": {
            "code": "XXX12345678",
            "start_date": "2021-03-12",
            "end_date": "2021-03-16",
            "expected_payout_amount": "3800.00",
            "guest_details": {
                "localized_description": "4 guests",
                "number_of_adults": 2,
                "number_of_children": 2,
                "number_of_infants": 0
            },
            "guest_email": "wayne_woodbridge@bnb.com",
            "guest_first_name": "Wayne",
            "guest_last_name": "Woodbridge",
            "guest_phone_numbers": [
                "639123456789",
                "639123456789"
            ],
            "listing_security_price_accurate": "500.00",
            "host_currency": "AUD",
            "nights": 4,
            "number_of_guests": 4,
            "status_type": "accepted",
            "total_paid_amount_accurate": "4300.00"
        } 
    }
    ```

    - Booking.com (Payload # 1)
    ```
    {
      "reservation_code": "YYY12345678",
      "start_date": "2021-04-14",
      "end_date": "2021-04-18",
      "nights": 4,
      "guests": 4,
      "adults": 2,
      "children": 2,
      "infants": 0,
      "status": "accepted",
      "guest": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "wayne_woodbridge@bnb.com"
      },
      "currency": "AUD",
      "payout_price": "4200.00",
      "security_price": "500",
      "total_price": "4700.00"
    }
    ```
* Testing the endpoint `POST /reservation`
  * set POST request's`application/type` to JSON
