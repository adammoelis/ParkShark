class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :owner, index: true
      t.belongs_to :visitor, index: true
      t.belongs_to :spot, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
