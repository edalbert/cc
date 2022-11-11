class AddReservationIdToGuests < ActiveRecord::Migration[7.0]
  def change
    add_reference :guests, :reservation, index: true
  end
end
