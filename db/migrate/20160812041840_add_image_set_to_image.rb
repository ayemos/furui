class AddImageSetToImage < ActiveRecord::Migration[5.0]
  def change
    add_reference :images, :image_set, foreign_key: true
  end
end
