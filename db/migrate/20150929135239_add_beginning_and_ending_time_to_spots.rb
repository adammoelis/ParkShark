class AddBeginningAndEndingTimeToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :beginning_time, :datetime
    add_column :spots, :ending_time, :datetime
  end
end
