class RemoveImageUrlFromSpots < ActiveRecord::Migration
  def change
    remove_column :spots, :image_url, :string
  end
end
