class ReservationsController < ApplicationController
  # GET /reservations
  def index
    reservations = Reservation.all

    render json: reservations
  end

  # POST /reservations
  def create
    reservation = Reservation.new(reservation_params)

    if reservation.save
      render json: reservation, status: :created
    else
      render json: {errors: reservation.errors.messages}, status: 400
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :document, :cell_phone, :email, :movie_id, :reservation_date)
  end
end
