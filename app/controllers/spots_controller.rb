class SpotsController < ApplicationController
  before_action :find_spot, only: [:show]

  def index
    @spots = Spot.all
  end

  def new
  end

  def create
    @spot = Spot.new(post_params)
    if @spot.save
      redirect_to spot_path(@spot)

    else

    end
  end

  def show
  end

  private

  def post_params
    params.require(:spot).permit(:title, :address, :city, :state, :image_url, :date, :price, :beginning_time, :ending_time, )
  end

  def find_spot
    @spot = Spot.find(params[:id])
  end
end
