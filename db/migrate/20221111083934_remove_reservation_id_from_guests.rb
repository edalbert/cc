class RemoveReservationIdFromGuests < ActiveRecord::Migration[7.0]
  def change
    remove_column :guests, :reservation_id, :integer
  end
end
