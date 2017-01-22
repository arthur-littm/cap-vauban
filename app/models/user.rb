class User < ApplicationRecord
  has_many :bookings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true, format: { with: /[0-9]{7,}/ }
  validates :email, presence: true, email: true
  validates :password, presence: true, on: :create


end
