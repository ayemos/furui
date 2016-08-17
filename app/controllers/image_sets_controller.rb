class ImageSetsController < ApplicationController
  before_action :set_image_set, only: [:show]

  # GET /image_sets
  def index
    @image_sets = ImageSet.all
  end

  # GET /image_sets/1
  def show
    @image = @image_set.images.unknown.first
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_set
      @image_set = ImageSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_set_params
      params.require(:image_set).permit(:name)
    end
end
