require 'rails_helper'

describe ReservationParsingService do

  describe '#transformer' do
    subject { described_class.new(params).transformer }

    context 'when params has a `reservation` key' do
      let(:params) do
        {
          reservation: { code: :details }
        }
      end
      it 'chooses the correct transformer service' do
        expect(subject).to be_a AirBnbParsingService
      end
    end

    context 'when params do not include a `reservation` key' do
      let(:params) do
        { code: :new_code }
      end
      it 'chooses the correct transformer service' do
        expect(subject).to be_a BookingDotComParsingService
      end
    end
  end

  describe '#process_guest' do
    subject { described_class.new(params).process_guest }

    let(:params) do
      {
        reservation: {
          guest_email: email,
          guest_first_name: 'Wayne',
          guest_last_name: 'Woodbridge',
          guest_phone_numbers: ['639123456789', '639123456789'],
        }
      }
    end
    let(:email) { Faker::Internet.email }

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
end
