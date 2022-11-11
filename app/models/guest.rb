# == Schema Information
#
# Table name: guests
#
#  id             :integer          not null, primary key
#  email          :string
#  first_name     :string
#  last_name      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reservation_id :integer
#
# Indexes
#
#  index_guests_on_email           (email) UNIQUE
#  index_guests_on_reservation_id  (reservation_id)
#
class Guest < ApplicationRecord
  validates :email, uniqueness: true

  has_many :guest_contacts
  belongs_to :reservation

  accepts_nested_attributes_for :guest_contacts
end
