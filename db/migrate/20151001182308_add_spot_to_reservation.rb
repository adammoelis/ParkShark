class AddSpotToReservation < ActiveRecord::Migration
  def change
    add_reference :reservations, :spot, index: true
  end
end
