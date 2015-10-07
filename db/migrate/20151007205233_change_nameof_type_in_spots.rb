class ChangeNameofTypeInSpots < ActiveRecord::Migration
  def change
    rename_column :spots, :type, :type_of_spot
  end
end
