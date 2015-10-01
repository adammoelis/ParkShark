class PurchasesController < ApplicationController

  def new
    @owner = User.find(params[:ids][:owner_id])
    @visitor = User.find(params[:ids][:visitor_id])
    @spot = Spot.find(params[:ids][:spot_id])
    @token = get_client_token
  end

  def checkout
    @owner = User.find(params[:owner_id])
    @visitor = User.find(params[:visitor_id])
    @spot = Spot.find(params[:spot_id])
    nonce = params[:payment_method_nonce]
    result = Braintree::Transaction.sale(
      :amount => @spot.price,
      :payment_method_nonce => nonce,
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
      }
    )
    binding.pry
    if result.success?
      # pay_owner(get_client_token)
      flash[:notice] = "Congrats! You just purchased #{@spot.title} for $#{@spot.price}"
      redirect_to spot_path(@spot)
    else
      flash[:notice] = "Sorry, there was a problem. #{result.message}"
      redirect_to spot_path(@spot)
    end
  end

  private

  def get_client_token
    Braintree::ClientToken.generate
  end

end
