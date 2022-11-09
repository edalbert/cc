class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :code
      t.date :start_date
      t.date :end_date
      t.integer :number_of_nights
      t.integer :number_of_guests
      t.integer :number_of_children
      t.integer :number_of_infants
      t.integer :number_of_adults
      t.string :description
      t.string :status
      t.string :host_currency
      t.decimal :payout_price
      t.decimal :security_price
      t.decimal :total_price

      t.timestamps
    end
    add_index :reservations, :code, unique: true
  end
end
