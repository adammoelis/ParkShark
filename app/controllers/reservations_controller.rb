class ReservationsController < ApplicationController

  def reserve_spot
    @spot = Spot.find(params[:id])
  end

  def confirm_spot
    @spot = Spot.find(params[:id])
    @spot.available = false
    @spot.save 
    redirect_to spot_path(@spot)

  end
end
