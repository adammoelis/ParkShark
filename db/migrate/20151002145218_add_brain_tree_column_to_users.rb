class AddBrainTreeColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :brain_tree_id, :integer
  end
end
