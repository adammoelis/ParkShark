class AddBrainTreeMerchantIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :braintree_merchant_id, :string
  end
end
