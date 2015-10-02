class RemoveStuffFromSpots < ActiveRecord::Migration
  def change
    remove_column :spots, :beginning_time, :datetime
    remove_column :spots, :ending_time, :datetime
    remove_column :spots, :price, :float
  end
end
