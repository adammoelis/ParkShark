class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.datetime :beginning_time
      t.datetime :ending_time
      t.boolean :available
      t.belongs_to :spot, index: true

      t.timestamps null: false
    end
  end
end
