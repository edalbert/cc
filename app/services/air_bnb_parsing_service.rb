require 'active_support'
require 'active_support/core_ext'

class AirBnbParsingService
  attr_reader :attributes

  EXPECTED_KEYS = %i[reservation code guest_details end_date host_currency number_of_guests nights
    expected_payout_amount listing_security_price_accurate start_date status_type
    total_paid_amount_accurate localized_description number_of_adults number_of_children
    number_of_infants guest_email guest_first_name guest_last_name guest_phone_numbers
  ]

  # To use:
  #
  # service = AirBnbParsingService.new(params[:reservation])
  # service.reservation_params
  def initialize(attributes)
    @attributes = attributes.deep_symbolize_keys
  end

  # Returns params that are specific to the Reservation model and leaves out
  # guest details
  #
  # @return [Hash]
  def reservation_params
    {
      code: attributes[:code],
      description: attributes.dig(:guest_details, :localized_description),
      end_date: attributes[:end_date],
      host_currency: attributes[:host_currency] ,
      number_of_adults: attributes.dig(:guest_details, :number_of_adults),
      number_of_children: attributes.dig(:guest_details, :number_of_children),
      number_of_guests: attributes[:number_of_guests],
      number_of_infants: attributes.dig(:guest_details, :number_of_infants),
      number_of_nights: attributes[:nights],
      payout_price: attributes[:expected_payout_amount],
      security_price: attributes[:listing_security_price_accurate],
      start_date: attributes[:start_date],
      status: attributes[:status_type],
      total_price: attributes[:total_paid_amount_accurate],
    }
  end

  # Params that are specific to the Guest model
  #
  # @return [Hash]
  def guest_params
    {
      email: attributes[:guest_email],
      first_name: attributes[:guest_first_name],
      last_name: attributes[:guest_last_name],
      guest_contacts_attributes: attributes[:guest_phone_numbers]&.map { |phone| { phone: phone } },
    }
  end
end
