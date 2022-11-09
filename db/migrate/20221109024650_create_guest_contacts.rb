class CreateGuestContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :guest_contacts do |t|
      t.references :guest, null: false, foreign_key: true
      t.string :phone

      t.timestamps
    end
  end
end
