class ChangeLocationToAddress < ActiveRecord::Migration
  def change
    rename_column :spots, :location, :address
  end
end
