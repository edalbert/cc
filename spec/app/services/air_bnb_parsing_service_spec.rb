require './app/services/air_bnb_parsing_service'

describe AirBnbParsingService do
  let(:attributes) do
    {
      'code': 'XXX12345678',
      'start_date': '2021-03-12',
      'end_date': '2021-03-16',
      'expected_payout_amount': '3800.00',
      'guest_details': {
        'localized_description': '4 guests',
        'number_of_adults': 2,
        'number_of_children': 2,
        'number_of_infants': 0
      },
      'guest_email': 'wayne_woodbridge@bnb.com',
      'guest_first_name': 'Wayne',
      'guest_last_name': 'Woodbridge',
      'guest_phone_numbers': ['639123456789', '639123456789'],
      'listing_security_price_accurate': '500.00',
      'host_currency': 'AUD',
      'nights': 4,
      'number_of_guests': 4,
      'status_type': 'accepted',
      'total_paid_amount_accurate': '4300.00',
    }
  end
  let(:service) { described_class.new(attributes) }

  describe '#transform' do
    context 'when nicely-formed params are provided' do
      let(:expected_data) do
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
        }
      end

      it 'transforms the hash into something the database can save' do
         expect(service.transform).to eq(expected_data)
      end
    end

    context 'when the params that are provided does not have all the fields' do
      let(:attributes) { {} }
      subject { service.transform }

      it 'provides a fully-formed hash but with nil values' do
        expect(subject).to be_a Hash
        expect(subject.keys).to match_array(%i[code description end_date host_currency
          number_of_adults number_of_children number_of_guests number_of_infants
          number_of_nights payout_price security_price start_date status total_price]
        )
      end
    end
  end
end