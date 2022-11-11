require './app/services/booking_dot_com_parsing_service'

describe BookingDotComParsingService do
  let(:attributes) do
    {
      "reservation_code": "YYY12345678",
      "start_date": "2021-04-14",
      "end_date": "2021-04-18",
      "nights": 4,
      "guests": 4,
      "adults": 2,
      "children": 2,
      "infants": 0,
      "status": "accepted",
      "guest": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "wayne_woodbridge@bnb.com"
      },
      "currency": "AUD",
      "payout_price": "4200.00",
      "security_price": "500",
      "total_price": "4700.00",
    }
  end

  let(:service) { described_class.new(attributes) }

  describe '#reservation_params' do
    subject { service.reservation_params }
    let(:expected_data) do
      {
        code: attributes[:reservation_code],
        description: nil,
        end_date: attributes[:end_date],
        host_currency: attributes[:currency] ,
        number_of_adults: attributes[:adults],
        number_of_children: attributes[:children],
        number_of_guests: attributes[:guests],
        number_of_infants: attributes[:infants],
        number_of_nights: attributes[:nights],
        payout_price: attributes[:payout_price],
        security_price: attributes[:security_price],
        start_date: attributes[:start_date],
        status: attributes[:status],
        total_price: attributes[:total_price],
      }
    end
    it 'returns the expected data' do
      expect(subject).to eq expected_data
    end
  end

  describe '#guest_params' do
    subject { service.guest_params }

    context 'when guest details are present in the hash' do
      let(:expected_data) do
        {
          email: 'wayne_woodbridge@bnb.com',
          first_name: 'Wayne',
          last_name: 'Woodbridge',
          guest_contacts_attributes: [{ phone: '639123456789' }],
        }
      end

      it 'returns only guest-specific details' do
        expect(subject.keys).to match_array(
          %i[email first_name last_name guest_contacts_attributes]
        )
        expect(subject).to eq(expected_data)
      end
    end

    context 'when there is no guest detail present in the hash' do
      it 'returns a fully-formed hash with nil values' do
        expect(subject).to be_a Hash
        expect(subject.keys).to match_array(
          %i[email first_name last_name guest_contacts_attributes]
        )
      end
    end
  end
end