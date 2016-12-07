class Flat < ApplicationRecord
  has_attachment :banner_photo
  has_attachments :photos
end
