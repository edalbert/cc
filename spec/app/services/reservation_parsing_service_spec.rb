require 'rails_helper'

describe ReservationParsingService do
  let(:email) { Faker::Internet.email }
  let(:number_of_guests) { 36 }
  let(:code) { Faker::Code.unique.nric }
  let(:airbnb_params) do
    {
      "reservation": {
        "code": "XXX12345678",
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
          "localized_description": "4 guests",
          "number_of_adults": 2,
          "number_of_children": 2,
          "number_of_infants": 0,
        },
        "guest_email": email,
        "guest_first_name": "Wayne",
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
          "639123456789",
          "639123456789",
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4300.00",
      }
    }
  end

  let(:booking_dot_com_params) do
    {
      "reservation_code": code,
      "start_date": "2021-04-14",
      "end_date": "2021-04-18",
      "nights": 4,
      "guests": number_of_guests,
      "adults": 2,
      "children": 2,
      "infants": 0,
      "status": "accepted",
      "guest": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": email,
      },
      "currency": "AUD",
      "payout_price": "4200.00",
      "security_price": "500",
      "total_price": "4700.00",
    }
  end
  describe '#transformer' do
    subject { described_class.new(params).transformer }

    context 'when params has a `reservation` key' do
      let(:params) { airbnb_params }
      it 'chooses the correct transformer service' do
        expect(subject).to be_a AirBnbParsingService
      end
    end

    context 'when params do not include a `reservation` key' do
      let(:params) { booking_dot_com_params }
      it 'chooses the correct transformer service' do
        expect(subject).to be_a BookingDotComParsingService
      end
    end
  end

  describe '#process_guest' do
    subject { described_class.new(params).process_guest }

    let(:params) { airbnb_params }

    context 'when there is an existing guest with the same email' do
      before { Guest.create email: email, first_name: 'BP' }
      it 'does not save a new Guest' do
        expect { subject }.to_not change(Guest, :count)
        expect(Guest.last.first_name).to eq 'Wayne'
      end
    end

    context 'when there is no existing guest with the same email' do
      it 'creates a new Guest with the attributes provided' do
        expect { subject }.to change(Guest, :count).by(1)
        expect(Guest.last.first_name).to eq 'Wayne'
        expect(Guest.last.last_name).to eq 'Woodbridge'
        expect(Guest.last.guest_contacts.size).to eq(2)
      end
    end
  end

  describe '#process_reservation' do
    subject { described_class.new(params).process_reservation }
    let(:params) { booking_dot_com_params }

    context 'when there is an existing reservation with the same reservation code' do
      let(:email) { Faker::Internet.unique.email }
      let(:guest) { Guest.create email: email }
      let(:number_of_guests) { 45 }
      before { Reservation.create(code: code, number_of_guests: 35, guest: guest) }

      it 'does not create a new reservation and updates the reservation with the param data' do
        expect { subject }.to_not change(Reservation, :count)
        expect(Reservation.last.number_of_guests).to eq number_of_guests
        expect(subject).to be_a Reservation
      end
    end

    context 'when there is no existing reservation with the same reservation code' do
      let(:code) { Faker::Code.unique.nric }
      let(:guest) { Guest.create email: Faker::Internet.unique.email }
      it 'creates a new reservation' do
        expect { subject }.to change(Reservation, :count).by(1)
        expect(Reservation.find_by(code: code).number_of_guests).to eq 36
        expect(subject).to be_a Reservation
      end
    end
  end

  describe '#process' do
    subject { described_class.new(params).process }

    let(:params) { airbnb_params }

    let(:email) { Faker::Internet.email }

    it 'returns the reservation' do
      expect(subject).to be_a(Reservation)
    end
  end
end
