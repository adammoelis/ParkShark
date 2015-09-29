class SpotsController < ApplicationController

  def new
  end

  def create
    binding.pry
    @spot = Spot.new(post_params)
  end

  private

  def post_params
    params.require(:spot).permit(:title, :location, :image_url, :date, :price)
  end
end
