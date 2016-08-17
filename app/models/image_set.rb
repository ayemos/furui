class ImageSet < ApplicationRecord
  has_many :images, dependent: :destroy
end
