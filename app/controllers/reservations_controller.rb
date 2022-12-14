class ReservationsController < ApplicationController
  wrap_parameters false

  def index
    @reservations = Reservation.all

    render json: @reservations
  end

  def create
    reservation_params = request.request_parameters

    reservation = ReservationParsingService.new(reservation_params).process_reservation

    if reservation.present?
      render json: reservation.as_json(include: :guest)
    else
      head :service_unavailable
    end
  end
end
