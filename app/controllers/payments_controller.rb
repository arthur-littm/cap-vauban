class PaymentsController < ApplicationController
  before_action :set_order

  def create
    @booking = @order.booking
    @amount = @order.amount_cents
    @code = params[:couponCode]

    if !@code.blank?
      @discount = get_discount(@code)

      if @discount.nil?
        flash[:error] = 'Coupon code is not valid or expired.'
        redirect_to booking_path(@booking)
        return
      else
        @discount_amount = @amount * @discount
        @final_amount = @amount - @discount_amount.to_i
        @booking.price_cents = @final_booking_price
      end

      charge_metadata = {
        :coupon_code => @code,
        :coupon_discount => (@discount * 100).to_s + "%"
      }

      charge_metadata ||= {}
    else
      @final_amount = @amount
    end

    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
      )

    charge = Stripe::Charge.create(
    customer:     customer.id,   # You should store this customer id and re-use it.
    amount:       @final_amount, # or amount_pennies
    description:  "Payment booking #{@booking.flat.title}, for order #{@booking.start_date} to #{@booking.end_date}, by #{@booking.user.first_name} #{@booking.user.last_name}",
    currency:     @order.amount.currency,
    :metadata    => charge_metadata
    )

    @order.update(payment: charge.to_json, state: 'paid')
    @booking.send_admin_payment_mail
    redirect_to booking_path(@booking)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_order_payment_path(@order)
  end

  private

  COUPONS = {
    'VAUBAN2017' => 0.10,
  }

  def get_discount(code)
  # Normalize user input
  code = code.gsub(/\s+/, '')
  code = code.upcase
  COUPONS[code]
end

def set_order
  @order = Order.where(state: 'pending').find(params[:order_id])
end
end
