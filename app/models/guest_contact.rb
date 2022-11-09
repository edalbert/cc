# == Schema Information
#
# Table name: guest_contacts
#
#  id         :integer          not null, primary key
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  guest_id   :integer          not null
#
# Indexes
#
#  index_guest_contacts_on_guest_id  (guest_id)
#
# Foreign Keys
#
#  guest_id  (guest_id => guests.id)
#
class GuestContact < ApplicationRecord
  belongs_to :guest
end
