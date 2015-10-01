class AddDescriptionToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :description, :text
  end
end
