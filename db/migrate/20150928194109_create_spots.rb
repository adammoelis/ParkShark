class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :title
      t.string :location
      t.boolean :available
      t.datetime :date
      t.float :price
      t.string :image_url
      t.belongs_to :owner, index: true

      t.timestamps null: false
    end
  end
end
