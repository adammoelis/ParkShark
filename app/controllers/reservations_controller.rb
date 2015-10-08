class ReservationsController < ApplicationController

  def index
    @listings = current_user.listings
  end
  def reserve_spot
    @spot = Spot.find(params[:id])
  end

  def confirm_spot
    @spot = Spot.find(params[:spot_id])
    @listing = Spot.find(params[:listing_id])
    @reservation = Reservation.new
    @reservation.visitor = current_user
    @reservation.owner = @spot.owner
    @reservation.save
    @listing.available = false
    @listing.save
    redirect_to spot_path(@spot)
  end

  def new
    @spot = Spot.find(params[:spot_id])
    @listing = Listing.find(params[:listing_id])
    @owner = @spot.owner
    @visitor = current_user
    @listing = Listing.find(params[:listing_id])
    @token = get_client_token
    unless @listing.available
      flash[:error] = "That spot is no longer available"
      redirect_to spot_path(@spot)
    end
  end

  private

  def get_client_token
    Braintree::ClientToken.generate
  end

end
