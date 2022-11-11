require './app/services/reservation_parsing_service'
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
end