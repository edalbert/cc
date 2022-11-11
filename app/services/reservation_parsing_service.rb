require 'active_support'
require 'active_support/core_ext'

class ReservationParsingService
  attr_accessor :transformer, :raw_attributes
  # To use:
  #
  # ReservationParsingService.new(params).process
  def initialize(attributes)
    attributes.deep_symbolize_keys!
    @transformer = if attributes[:reservation].present?
                     AirBnbParsingService.new(attributes[:reservation])
                   else
                     BookingDotComParsingService.new(attributes)
                   end
    @raw_attributes = attributes
  end
end
