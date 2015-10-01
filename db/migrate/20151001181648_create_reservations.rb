class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.belongs_to :visitor, index: true
      t.timestamps null: false
    end
  end
end
