class AddOwnerToReservation < ActiveRecord::Migration
  def change
    add_reference :reservations, :owner, index: true
  end
end
