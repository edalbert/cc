require 'active_support'
require 'active_support/core_ext'

class BookingDotComParsingService
  attr_reader :attributes

  EXPECTED_KEYS = %w[reservation_code guest end_date currency adults
    children guests infants nights payout_price security_price start_date status
    total_price
  ]

  # To use:
  #
  # service = BookingDotComParsingService.new(params[:reservation])
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
      code: attributes[:reservation_code],
      description: attributes.dig(:guest, :localized_description),
      end_date: attributes[:end_date],
      host_currency: attributes[:currency] ,
      number_of_adults: attributes[:adults],
      number_of_children: attributes[:children],
      number_of_guests: attributes[:guests],
      number_of_infants: attributes[:infants],
      number_of_nights: attributes[:nights],
      payout_price: attributes[:payout_price],
      security_price: attributes[:security_price],
      start_date: attributes[:start_date],
      status: attributes[:status],
      total_price: attributes[:total_price],
    }
  end

  # Params that are specific to the Guest model
  #
  # @return [Hash]
  def guest_params
    {
      email: attributes.dig(:guest, :email),
      first_name: attributes.dig(:guest, :first_name),
      last_name: attributes.dig(:guest, :last_name),
      guest_contacts_attributes: [ { phone: attributes.dig(:guest, :phone) }].compact,
    }
  end
end
