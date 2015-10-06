class RenameTimeOfDayInListings < ActiveRecord::Migration
  def change
    rename_column :listings, :time_of_day, :beginning_time_of_day
    add_column :listings, :ending_time_of_day, :string
  end
end
