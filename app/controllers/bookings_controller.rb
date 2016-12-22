class BookingsController < ApplicationController
  before_action :authenticate_admin!, only: [:requests, :booking_status, :edit, :destroy]

  def index
    @bookings = Booking.all.where(user: current_user).order(start_date: :asc)
  end

  def requests
    admin = User.all.where(admin: true)
    leport = Flat.all.where(title: "Le Port")
    laplage = Flat.all.where(title: "La Plage")

    @bookings = Booking.all.order(start_date: :asc)
    @recent = Booking.all.order(created_at: :desc).last(20)
    @users_bookings = Booking.all.order(start_date: :asc).where.not(user: admin)
    @bookings_leport = @bookings.where(flat: leport)
    @bookings_laplage = @bookings.where(flat: laplage)
    @confirmed = @bookings.where(status: "confirmed")
    @unconfirmed = @bookings.where(status: "unconfirmed")
    @unpaid = @users_bookings
    @cancelled = @bookings.where(status: "cancelled")
    @admin_bookings = Booking.all.order(start_date: :asc).where(user: admin)
  end

  def show
    @booking = Booking.find(params[:id])
    @order = @booking.order
  end

  def new
    @booking = Booking.new
  end

  def create
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(booking_params)
    if (@booking.start_date != "" && @booking.end_date != "") && (@booking.start_date != @booking.end_date) && @booking.start_date.to_date < @booking.end_date.to_date
      @booking.user = current_user
      @booking.flat = @flat
      @booking.sku = "booking-#{@flat.title.delete(' ').downcase}"
      @booking.price_cents = total_price(@booking)
      @order  = Order.create!(booking_sku: @booking.sku, amount: @booking.price_cents, state: 'pending')
      @order.booking = @booking
      @order.save
      if @booking.save
        redirect_to booking_path(@booking)
      else
        redirect_to flat_path(@flat), alert: "Something went wrong, booking request cancelled"
      end
    else
      redirect_to flat_path(@flat), alert: "You need to select two different dates to book a flat"
    end
  end

  def booking_status
    @booking = Booking.find(params[:id])
    if @booking.status == "unconfirmed"
      @booking.status = "confirmed"
      @booking.save
      if I18n.locale == I18n.default_locale
        @booking.send_new_booking_mail_fr
      else
        @booking.send_new_booking_mail_en
      end
      redirect_to requests_path
    else
      redirect_to requests_path, alert: "Something went wrong, booking unconfirmed"
    end
  end

  def total_price(booking)
    start_d = Date.parse(booking.start_date)
    end_d = Date.parse(booking.end_date)

    multiplier = (end_d.cweek - start_d.cweek) - 1

    date = start_d
    total_price = booking_price(date)
    multiplier.times do
      date += 7
      total_price += booking_price(date)
    end
    return total_price
  end

  def booking_price(date)
    # Date format -> yyyy-mm-dd
    start_d = date

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
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @order = @booking.order
    if @booking.update(booking_params)
      @order.amount = @booking.price_cents
      @order.save
      redirect_to requests_path, notice: "Booking successfully updated"
    else
      redirect_to requests_path, alert: "Something went wrong"
    end
  end

  def cancel_booking
    @booking = Booking.find(params[:id])
    @booking.status = "cancelled"
    if @booking.save
      if I18n.locale == I18n.default_locale
        @booking.send_cancelled_booking_mail_fr
      else
        @booking.send_cancelled_booking_mail_en
      end
      redirect_to requests_path, notice: "Booking successfully cancelled"
    else
      redirect_to requests_path, alert: "Something went wrong, booking not cancelled"
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    if @booking.destroy
      redirect_to requests_path, notice: "Booking successfully deleted"
    else
      redirect_to requests_path, alert: "Something went wrong!"
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:flat_id, :price_cents, :start_date, :end_date, :status, :message, :admin_comment)
  end

  def order_params
    params.require(:order).permit(:state)
  end
end
