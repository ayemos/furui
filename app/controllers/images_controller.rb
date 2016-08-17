class ImagesController < ApplicationController
  def index
    @image = Image.where('category <> ?', 'unknown')
  end

  def judge
    Image.find(params['image_id']).update_attribute(:category, params['category'])
    redirect_to :back
  end
end
