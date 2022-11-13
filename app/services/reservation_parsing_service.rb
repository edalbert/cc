require 'active_support'
require 'active_support/core_ext'
class ReservationParsingService
  attr_accessor :transformer, :raw_attributes
  # To use:
  #
  # ReservationParsingService.new(params).process
  def initialize(attributes)
    attributes.deep_symbolize_keys!
    @transformer = if attributes[:reservation].present?
                     AirBnbParsingService.new(attributes[:reservation])
                   else
                     BookingDotComParsingService.new(attributes)
                   end
    @raw_attributes = attributes
  end

  # Creates or Updates a Reservation if it already exists
  # Creates or Updates a Guest if it exists
  def process
    guest = process_guest
    # reservation = process_reservation
  end

  # private

  def reservation_params
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

  def process_reservation
    reservation = Reservation.find_or_initialize_by(code: reservation_params[:code])
    reservation.attributes = reservation_params
    reservation.guest = process_guest
    reservation.save
  end
end
