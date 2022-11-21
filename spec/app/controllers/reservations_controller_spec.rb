require 'rails_helper'

describe ReservationsController, type: :controller do
  context 'when providing well-formed params' do
    let(:code) { "XXX12345678" }
    let(:params) do
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
          "guest_email": Faker::Internet.email,
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
    it 'returns reservation data along with guest data' do
      post :create, params: params, format: :json

      expect(response).to be_successful
      body = JSON.parse(response.body)

      expect(body['code']).to eq(code)
      expect(body.keys).to include('guest')
    end
  end

  context 'when providing ill-formed params in the request' do
    let(:params) { { random: :stuff } }

    it 'returns reservation data along with guest data' do
      post :create, params: params, format: :json

      expect(response.status).to eq 503
    end
  end
end