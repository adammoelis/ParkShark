class Purchase < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  belongs_to :visitor, :class_name => 'User'
  belongs_to :spot

  def self.braintree_transaction(payment_nonce, params, listing, owner)
    service_fee = (listing.price * 0.1)
    Braintree::Transaction.sale(
      :merchant_account_id => owner.braintree_merchant_id,
      :amount => listing.price,
      :payment_method_nonce => payment_nonce,
      # using sprintf to format service fee correctly for Braintree
      :service_fee_amount => sprintf('%.2f', service_fee),
      :options => {
        :submit_for_settlement => true
      },
      :customer => {
        :first_name => params[:first_name],
        :last_name => params[:last_name],
        :phone => owner.phone,
        :email => owner.email
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

  def self.successful_transaction(listing, reservation, spot, owner, visitor)
    listing.available = false
    listing.save
    reservation = Reservation.new(owner: spot.owner, visitor: visitor, spot: spot)
    reservation.save
    # notifies owner of purchased spot
    PurchaseMailer.purchase_owner(owner, visitor, spot).deliver_now
    # sends email to visitor confirming their purchase
    PurchaseMailer.purchase_visitor(visitor, owner, spot).deliver_now
  end

end
