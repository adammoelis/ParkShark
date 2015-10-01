class ReservationsController < ApplicationController

  def reserve_spot
    @spot = Spot.find(params[:id])
  end

  def confirm_spot
    @spot = Spot.find(params[:spot_id])
    @listing = Spot.find(params[:listing_id])
    @listing.available = false
    @listing.save
    binding.pry
    redirect_to spot_path(@spot)
  end

  def new
    @spot = Spot.find(params[:spot_id])
    @listing = Spot.find(params[:listing_id])
  end
end
