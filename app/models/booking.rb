class Booking < ApplicationRecord
  after_create :send_admin_new_booking
  belongs_to :flat
  belongs_to :user
  has_one :order

  validates :start_date, presence: true
  validates :end_date, presence: true

  monetize :price_cents

  def send_new_booking_mail
    UserMailer.new_booking(self.user, self).deliver_now
  end

  def send_payment_mail
    UserMailer.payment(self.user, self).deliver_now
  end

  def send_cancelled_booking_mail
    UserMailer.cancelled_booking(self.user, self).deliver_now
  end
  private
  def send_admin_new_booking
    UserMailer.admin_new_booking(self.user, self).deliver_now
  end
end
