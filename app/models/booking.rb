class Booking < ApplicationRecord
  belongs_to :flat
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true

  monetize :price_cents

  def send_new_booking_mail
    UserMailer.new_booking(self.user, self).deliver_now
    # UserMailer.new_booking(self.user).deliver_later(wait: 5.minutes)
  end

  def send_cancelled_booking_mail
    UserMailer.cancelled_booking(self.user, self).deliver_now
    # UserMailer.new_booking(self.user).deliver_later(wait: 5.minutes)
  end
end
