class ReservationsController < ApplicationController
  wrap_parameters false

  def index
    @reservations = Reservation.all

    render json: @reservations
  end

  def create
    @reservation = request.request_parameters

    render json: @reservation
  end
end
