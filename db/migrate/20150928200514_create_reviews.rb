class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :body
      t.belongs_to :spot, index: true, foreign_key: true
      t.belongs_to :visitor, index: true

      t.timestamps null: false
    end
  end
end
