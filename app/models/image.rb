class Image < ApplicationRecord
  belongs_to :image_set

  enum category: [:unknown] + Rails.application.config.x.categories.keys
  enum status: { default: 0, checking: 1 }
end
