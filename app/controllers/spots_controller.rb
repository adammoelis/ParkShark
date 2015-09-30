class SpotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :update, :edit, :delete]
  before_action :find_spot, only: [:show]

  def index
    @spots = Spot.all
    @title = 'Your Car Needs A Home'
    @subtitle = 'Browse available parking spots below!'
  end

  def new
  end



  def create
    @spot = Spot.new(post_params)
    @spot.available = true
    @spot.owner_id = current_user.id
    if @spot.save
      redirect_to spot_path(@spot)
    else

    end
  end

  def show
  end

  private

  def post_params
    params.require(:spot).permit(:title, :address, :city, :state, :picture, :date, :available, :zip_code, :price, :beginning_time, :ending_time)
  end

  def find_spot
    @spot = Spot.find(params[:id])
  end
end
