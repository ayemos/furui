class ResultsController < ApplicationController
  before_action :set_image_set, only: [:show]

  def index
    @image_sets = ImageSet.all
  end

  def show
    @images = @image_set.images.where('category <> ?', 'unknown').all
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
