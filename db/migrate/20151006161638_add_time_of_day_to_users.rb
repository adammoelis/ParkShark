class AddTimeOfDayToUsers < ActiveRecord::Migration
  def change
    add_column :listings, :time_of_day, :string
  end
end
