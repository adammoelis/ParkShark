class AddLatitudeAndLongitudeToSpot < ActiveRecord::Migration
  def change
    add_column :spots, :latitude, :float
    add_column :spots, :longitude, :float
  end
end
