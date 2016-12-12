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
    # @booking.price_cents = booking_price(@booking)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      raise
    end
  end

  def booking_price(booking)
    case
    when booking.start_date.month == 1
      100
    when booking.start_date.month == 2
      200
    when booking.start_date.month == 3
      300
    when booking.start_date.month == 4
      400
    when booking.start_date.month == 5
      500
    when booking.start_date.month == 6
      600
    when booking.start_date.month == 7
      700
    when booking.start_date.month == 8
      800
    when booking.start_date.month == 9
      900
    when booking.start_date.month == 10
      1000
    when booking.start_date.month == 11
      1100
    when booking.start_date.month == 12
      1200
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: "Booking successfully updated"
    else
      redirect_to booking_path(@booking), alert: "Something went wrong"
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: "Booking successfully cancelled"
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
