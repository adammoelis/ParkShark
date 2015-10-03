class RemoveBraintreeColumnsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :brain_tree_id
    remove_column :users, :payment_token
  end
end
