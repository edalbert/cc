class RemoveGuestIdFromReservations < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :guest_id, :integer
  end
end
