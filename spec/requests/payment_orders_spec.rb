RSpec.describe 'Payment orders' do
  let(:customer) { create(:customer) }
  let(:headers) { { 'Authorization' => "Bearer #{auth_token}" } }

  context 'unauthenticated customer' do
    let(:auth_token) { 'invalid' }

    it 'returns authentication error' do
      get '/api/payment_orders', headers: headers

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'authenticated user' do
    let(:auth_token) { AuthenticateCustomer.for(customer.slice(:email, :password)).data }
    let(:receiver) { create(:customer, :with_account) }

    it 'returns a list of customer payment orders' do
      get '/api/payment_orders', headers: headers

      expect(response).to have_http_status(:ok)
    end

    it 'creates a payment order' do
      post '/api/payment_orders', headers: headers, params: {
        data: { full_name: receiver.full_name, iban: 'AT483200000012345864', amount: 10000 }
      }

      expect(response).to have_http_status(:created)
      expect(response.body).to include_json(
        data: { id: PaymentOrder.last.id },
      )
    end

    context 'completed payment order' do
      let(:payment_order) {
        create(:payment_order, status: :completed, issuer: customer, receiver: receiver)
      }

      it 'returns payment order data' do
        get "/api/payment_orders/#{payment_order.id}", headers: headers

        expect(response).to have_http_status(:ok)
        expect(response.body).to include_json(
          data: { status: 'completed' },
        )
      end
    end
  end
end
