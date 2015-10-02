class SpotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :update, :edit, :delete]
  before_action :find_spot, only: [:show]

  def index
    @spots = Spot.all
    @title = 'Your Car Needs A Home'
    @subtitle = 'Browse available parking spots below!'
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(post_params)
    @spot.available = true
    @spot.owner_id = current_user.id
    if @spot.save
      if params[:pictures]
        params[:pictures].each { |picture|
          @spot.pictures.create(picture: picture)
        }
      end
      flash[:notice] = 'Your spot was listed successfully.'
      redirect_to spot_path(@spot)
    else
      flash[:error] = 'Sorry, something went wrong when listing your spot.'
      render 'new'
    end
  end

  def show
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.update(post_params)
    redirect_to spot_path
  end

  def destroy
    @spot = Spot.find(params[:id])
    if @spot.destroy
      flash[:notice] = 'Your spot was removed successfully.'
      redirect_to user_spots_path(current_user)
    else
    end
  end

  private

  def post_params
    params.require(:spot).permit(:title, :address, :city, :state, :pictures, :description, :date, :available, :zip_code)
  end

  def find_spot
    @spot = Spot.find(params[:id])
  end
end
