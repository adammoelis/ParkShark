class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :location
      t.string :image_url
      t.string :phone

      t.timestamps null: false
    end
  end
end
