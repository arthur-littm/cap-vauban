class Suggestion < ApplicationRecord
  has_attachment :photo

  validates :title, presence: true
  validates :content, presence: true
  validates :content_english, presence: true
  validates :content_italian, presence: true
  validates :address, presence: true
end
