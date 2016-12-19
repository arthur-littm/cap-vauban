class PaymentsController < ApplicationController
  before_action :set_order

  def create
    booking = @order.booking
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
      )

    charge = Stripe::Charge.create(
    customer:     customer.id,   # You should store this customer id and re-use it.
    amount:       @order.amount_cents, # or amount_pennies
    description:  "Payment booking #{booking.flat.title}, for order #{booking.start_date} to #{booking.end_date}, by #{booking.user.first_name} #{booking.user.last_name}",
    currency:     @order.amount.currency
    )

    @order.update(payment: charge.to_json, state: 'paid')
    redirect_to booking_path(booking)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_order_payment_path(@order)
  end

  private

  def set_order
    @order = Order.where(state: 'pending').find(params[:order_id])
  end
end
