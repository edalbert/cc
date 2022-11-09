# == Schema Information
#
# Table name: reservations
#
#  id                 :integer          not null, primary key
#  code               :string
#  description        :string
#  end_date           :date
#  host_currency      :string
#  number_of_adults   :integer
#  number_of_children :integer
#  number_of_guests   :integer
#  number_of_infants  :integer
#  number_of_nights   :integer
#  payout_price       :decimal(, )
#  security_price     :decimal(, )
#  start_date         :date
#  status             :string
#  total_price        :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  guest_id           :integer
#
# Indexes
#
#  index_reservations_on_code      (code) UNIQUE
#  index_reservations_on_guest_id  (guest_id)
#
class Reservation < ApplicationRecord
  belongs_to :guest
end
