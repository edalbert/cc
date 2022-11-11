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
#
# Indexes
#
#  index_reservations_on_code  (code) UNIQUE
#
class Reservation < ApplicationRecord
  has_one :guest

  accepts_nested_attributes_for :guest
end
