class Booking < ApplicationRecord
  after_create :send_admin_new_booking
  belongs_to :flat
  belongs_to :user
  has_one :order, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true

  monetize :price_cents

  # FRANCAIS
  def send_new_booking_mail_fr
    UserMailer.french_new_booking(self.user, self).deliver_now
  end

  def send_cancelled_booking_mail_fr
    UserMailer.french_cancelled_booking(self.user, self).deliver_now
  end
  # ENGLISH
  def send_new_booking_mail_en
    UserMailer.english_new_booking(self.user, self).deliver_now
  end

  def send_cancelled_booking_mail_en
    UserMailer.english_cancelled_booking(self.user, self).deliver_now
  end
  # ADMIN Mails
  def send_admin_payment_mail
    UserMailer.payment(self.user, self).deliver_now
  end
  private
  def send_admin_new_booking
    UserMailer.admin_new_booking(self.user, self).deliver_now
  end
end
