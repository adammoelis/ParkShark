class PurchasesController < ApplicationController

  def checkout
    find_current_relations
    nonce = params[:payment_method_nonce]
    result = Purchase.braintree_transaction(nonce, params, @listing, @owner)
    if result.success?
      @listing.available = false
      @listing.save
      @reservation = Reservation.new(owner: @spot.owner, visitor: current_user, spot: @spot)
      @reservation.save
      # notifies owner of purchased spot
      PurchaseMailer.purchase_owner(@owner, @visitor, @spot).deliver_now
      # sends email to visitor confirming their purchase
      PurchaseMailer.purchase_visitor(@visitor, @owner, @spot).deliver_now
      flash[:notice] = "Congrats! You just purchased #{@spot.title} for $#{@listing.price}"
      redirect_to spot_path(@espot)
    else
      flash[:notice] = "Sorry, there was a problem. #{result.message}"
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

  def get_client_token
    Braintree::ClientToken.generate
  end

end
