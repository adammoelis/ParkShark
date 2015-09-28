class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.string :color
      t.integer :year
      t.string :license_plate
      t.belongs_to :visitor, index: true

      t.timestamps null: false
    end
  end
end
