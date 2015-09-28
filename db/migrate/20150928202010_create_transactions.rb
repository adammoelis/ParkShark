class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :spot, index: true, foreign_key: true
      t.boolean :complete

      t.timestamps null: false
    end
  end
end
