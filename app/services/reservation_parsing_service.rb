require 'active_support'
require 'active_support/core_ext'

class ReservationParsingService
  attr_accessor :transformer, :raw_attributes
  # To use:
  #
  # ReservationParsingService.new(params).process
  def initialize(attributes)
    @raw_attributes = attributes
    @transformer = if match_keys?(AirBnbParsingService::EXPECTED_KEYS)
                     AirBnbParsingService.new(attributes[:reservation])
                   elsif match_keys?(BookingDotComParsingService::EXPECTED_KEYS)
                     BookingDotComParsingService.new(attributes)
                   else
                     raise StandardError
                   end
  end

  # Creates or Updates a Reservation if it already exists
  # Creates or Updates a Guest if it exists
  def process
    process_reservation
  end

  # private

  def reservation_params
    puts transformer.class.name
    transformer.reservation_params
  end

  def guest_params
    @guest_params ||= transformer.guest_params
  end

  def process_guest
    guest = Guest.find_or_initialize_by(email: guest_params[:email])

    guest.attributes = guest_params
    guest.save
    guest.reload
  end

  # Process Reservation based on the available params
  #
  # @return [Reservation]
  def process_reservation
    reservation = Reservation.find_or_initialize_by(code: reservation_params[:code])
    reservation.attributes = reservation_params
    reservation.guest = process_guest
    reservation.save
    reservation.reload
  end

  # Check if the provided keys match expected keys from third-party services
  def match_keys?(expected_keys)
    all_keys = recursive_keys(raw_attributes.deep_symbolize_keys).flatten.compact
    (expected_keys - all_keys).empty?
  end

  def recursive_keys(data)
    data.keys + data.values.map{|value| recursive_keys(value) if value.is_a?(Hash) }
  end
end
