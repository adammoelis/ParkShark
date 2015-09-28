class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.belongs_to :author, index: true
      t.belongs_to :recipient, index: true

      t.timestamps null: false
    end
  end
end
