class ImagesController < ApplicationController
  # GET /images
  def index
    @image = Image.unknown.first
  end

  def judge
    Image.find(params['image_id']).update_attribute(:category, params['category'])
    redirect_to images_path
  end
end
