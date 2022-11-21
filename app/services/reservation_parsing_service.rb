require 'active_support'
require 'active_support/core_ext'

class ReservationParsingService
  attr_accessor :transformer, :raw_attributes
  # To use:
  #
  # ReservationParsingService.new(params).process
  def initialize(attributes)
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
end
