class AddListingToReservation < ActiveRecord::Migration
  def change
    add_reference :reservations, :listing, index: true
  end
end
