class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :category, default: 0, null: false, limit: 1
      t.string :type, null: false, default: 'LocalImage'

      # S3Image
      t.string :bucket_name
      t.string :key

      # LocalImage
      t.string :path

      t.timestamps
    end
  end
end
