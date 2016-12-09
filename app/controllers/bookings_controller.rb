class BookingsController < ApplicationController
  def index
    @bookings = Booking.all.where(user: current_user).order(start_date: :asc)
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flat = @flat
    @booking.price_cents = booking_price(@booking)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      raise
    end
  end

  def booking_price(booking)
    if booking.start_date < Date.parse('3rd May')
      return 300
    elsif booking.start_date > Date.parse('3rd May')
      return 400
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
