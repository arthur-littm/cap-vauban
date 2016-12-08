class Booking < ApplicationRecord
  belongs_to :flat
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true

  def start_time
    self.start_date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end
end
