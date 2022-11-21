class ReservationsController < ApplicationController
  wrap_parameters false

  def index
    @reservations = Reservation.all

    render json: @reservations
  end

  def create
    reservation_params = request.request_parameters

    reservation = ReservationParsingService.new(reservation_params).process
    render json: reservation
  end
end
