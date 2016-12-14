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
    if (@booking.start_date != "" && @booking.end_date != "") && (@booking.start_date != @booking.end_date)
      @booking.user = current_user
      @booking.flat = @flat
      @booking.price_cents = booking_price(@booking)
      if @booking.save
        redirect_to booking_path(@booking)
      else
        redirect_to flat_path(@flat), alert: "Something went wrong, booking request cancelled"
      end
    else
      redirect_to flat_path(@flat), alert: "You need to select two different dates to book a flat"
    end
  end

  def booking_price(booking)
    # Date format -> yyyy-mm-dd
    start_d = Date.parse(booking.start_date)
    end_d = Date.parse(booking.end_date)

    # start_d = booking.start_date.split("-")
    # end_date_array = booking.start_date.split("-")
    case
    when start_d.month == 12 && start_d.day >= 23
      week = 500
    when (start_d.month == 11 && start_d.day >= 4) || (start_d.month == 12 && start_d.day >= 1)
      week = 350
    when (start_d.month == 9 && start_d.day >= 16) || (start_d.month >= 10 && start_d.day >= 1)
      week = 500
    when start_d.month == 9 && start_d.day >= 2
      week = 650
    when (start_d.month == 8 && start_d.day >= 19) || (start_d.month == 9 && start_d.day >= 1)
      week = 800
    when (start_d.month == 7 && start_d.day >= 15) || (start_d.month == 8 && start_d.day >= 1)
      week = 950
    when start_d.month == 7 && start_d.day >= 1
      week = 800
    when start_d.month == 6 && start_d.day >= 10
      week = 650
    when (start_d.month == 4 && start_d.day >= 1) || (start_d.month == 5 && start_d.day >= 1) || (start_d.month == 6 && start_d.day >= 3)
      week = 500
    when (start_d.month == 1 && start_d.day >= 7) || (start_d.month == 2 && start_d.day >= 1) || (start_d.month == 3 && start_d.day >= 1)
      week = 350
    when (start_d.month == 12 && start_d.day >= 31) || (start_d.month == 1 && start_d.day >= 1)
      week = 500
    end

    multiplier = end_d.cweek - start_d.cweek

    return (multiplier * week)

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
