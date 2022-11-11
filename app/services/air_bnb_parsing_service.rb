class AirBnbParsingService
  attr_reader :attributes

  # To use:
  #
  # service = AirBnbParsingService.new(params[:reservation])
  # service.transform
  def initialize(attributes)
    @attributes = attributes
  end

  # parses AirBnB fields into fields that the db can understand
  #
  # @return [Hash]
  def transform
    {
      code: attributes[:code],
      description: attributes.dig(:guest_details, :localized_description),
      end_date: attributes[:end_date],
      host_currency: attributes[:host_currency] ,
      number_of_adults: attributes.dig(:guest_details, :number_of_adults),
      number_of_children: attributes.dig(:guest_details, :number_of_children),
      number_of_guests: attributes[:number_of_guests],
      number_of_infants: attributes.dig(:guest_details, :number_of_infants),
      number_of_nights: attributes[:nights],
      payout_price: attributes[:expected_payout_amount],
      security_price: attributes[:listing_security_price_accurate],
      start_date: attributes[:start_date],
      status: attributes[:status],
      total_price: attributes[:total_paid_amount_accurate],
    }.tap do |reservation|
      reservation[:guest_attributes] = {}
      reservation[:guest_attributes][:email] = attributes[:guest_email]
      reservation[:guest_attributes][:first_name] = attributes[:guest_first_name]
      reservation[:guest_attributes][:last_name] = attributes[:guest_last_name]
      reservation[:guest_attributes][:guest_contacts_attributes] =
        attributes[:guest_phone_numbers]&.map { |phone| { phone: phone } }
    end
  end
end
