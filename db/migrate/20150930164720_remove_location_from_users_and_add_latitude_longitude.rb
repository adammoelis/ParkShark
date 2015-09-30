class RemoveLocationFromUsersAndAddLatitudeLongitude < ActiveRecord::Migration
  def change
    remove_column :users, :location, :string
    add_column :users, :latitude, :string
    add_column :users, :longitude, :string
  end
end
