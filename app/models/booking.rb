class Booking < ApplicationRecord
  after_create :send_new_booking_mail
  belongs_to :flat
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true

  monetize :price_cents

  private

  def send_new_booking_mail
    UserMailer.new_booking(self.user).deliver_now
    # UserMailer.new_booking(self.user).deliver_later(wait: 15.minutes)
  end
end
