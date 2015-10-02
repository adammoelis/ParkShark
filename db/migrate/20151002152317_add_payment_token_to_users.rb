class AddPaymentTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :payment_token, :string
  end
end
