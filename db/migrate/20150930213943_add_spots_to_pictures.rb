class AddSpotsToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :spot_id, :integer, index: true
  end
end
