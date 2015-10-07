class AddTypeToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :type, :string
  end
end
