class PurchasesController < ApplicationController

  def checkout
    find_current_relations
    nonce = params[:payment_method_nonce]
    result = braintree_transaction(nonce)
    if result.success?
      # pay_owner
      @listing.available = false
      @listing.save
      @reservation = Reservation.new(owner: @spot.owner, visitor: current_user, spot: @spot)
      @reservation.save
      flash[:notice] = "Congrats! You just purchased #{@spot.title} for $#{@spot.price}"
      redirect_to spot_path(@spot)
    else
      flash[:notice] = "Sorry, there was a problem. #{result.message}"
      redirect_to spot_path(@spot)
    end
  end

  private

  # def pay_owner
  #   token = get_client_token
  #   # send money to owner (submerchant) from ParkShark (merchant)
  #   owner_result = Braintree::Transaction.sale(
  #     :customer_id => @owner.brain_tree_id,
  #     :amount => @listing.price
  #   )
  #   # notify owner of bought listing
  # end

  def find_current_relations
    @owner = User.find(params[:owner_id])
    @visitor = User.find(params[:visitor_id])
    @spot = Spot.find(params[:spot_id])
    @listing = Listing.find(params[:listing_id])
  end

  def braintree_transaction(payment_nonce)
    service_fee = (@listing.price * 0.1)
    binding.pry
    Braintree::Transaction.sale(
      :merchant_account_id => @owner.braintree_merchant_id,
      :amount => @listing.price,
      :payment_method_nonce => payment_nonce,
      # using sprintf to format service fee correctly for Braintree
      :service_fee_amount => sprintf('%.2f', service_fee),
      :options => {
        :submit_for_settlement => true
      },
      :customer => {
        :first_name => params[:first_name],
        :last_name => params[:last_name],
        :phone => @owner.phone,
        :email => @owner.email
      },
      :billing => {
        :first_name => params[:first_name],
        :last_name => params[:last_name],
        :company => params[:company],
        :street_address => params[:street_address],
        :extended_address => params[:extended_address],
        :locality => params[:city],
        :region => params[:state],
        :postal_code => params[:zip_code],
        :country_code_alpha2 => "US"
      },
    )
  end

  def get_client_token
    Braintree::ClientToken.generate
  end


end
