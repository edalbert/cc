class AddGuestIdToReservations < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :guest, index: true
  end
end
