class Flat < ApplicationRecord
  has_attachment :banner_photo
  has_attachments :photos

  has_many :bookings, dependent: :destroy
  has_many :reviews
  has_many :users, through: :bookings
end
