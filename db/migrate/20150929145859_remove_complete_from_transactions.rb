class RemoveCompleteFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :complete, :boolean
    add_column    :transactions, :status, :string
  end
end
