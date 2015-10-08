class PurchasesController < ApplicationController
  before_action :find_current_relations, only: [:checkout]
  before_action :available?, only: [:checkout]

  def checkout
    nonce = params[:payment_method_nonce]
    result = Purchase.braintree_transaction(nonce, params, @listing, @owner)
    if result.success?
      Purchase.successful_transaction(@listing, @reservation, @spot, @owner, @visitor)
      flash[:notice] = "Congrats! You just purchased #{@spot.title} for $#{@listing.price}"
      redirect_to spot_path(@spot)
    else
      flash[:error] = "Sorry, there was a problem. #{result.message}"
      render 'reservations/new'
    end
  end

  private

  def find_current_relations
    @owner = User.find(params[:owner_id])
    @visitor = User.find(params[:visitor_id])
    @spot = Spot.find(params[:spot_id])
    @listing = Listing.find(params[:listing_id])
  end

  def available?
    if !@listing.available
      flash[:error] = "Sorry, this listing is no longer available."
      redirect_to spot_path(@spot)
    end
  end

  def get_client_token
    Braintree::ClientToken.generate
  end

end
