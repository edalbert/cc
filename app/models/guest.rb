# == Schema Information
#
# Table name: guests
#
#  id         :integer          not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_guests_on_email  (email) UNIQUE
#
class Guest < ApplicationRecord
  validates :email, uniqueness: true

  has_many :guest_contacts
  has_many :reservations
end
