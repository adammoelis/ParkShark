class AddCityAndStateandZipCodeToUsers < ActiveRecord::Migration
  def change
    add_column :spots, :city, :string
    add_column :spots, :state, :string
    add_column :spots, :zip_code, :integer
  end
end
