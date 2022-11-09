class AddIndexToGuests < ActiveRecord::Migration[7.0]
  def change
    add_index :guests, :email, unique: true
  end
end
