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

  has_many :guest_contacts, dependent: :destroy
  has_many :reservations, dependent: :destroy

  accepts_nested_attributes_for :guest_contacts
end
