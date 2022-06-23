RSpec.describe 'Acounts' do
  let(:customer) { create(:customer) }
  let(:headers) { { 'Authorization' => "Bearer #{auth_token}" } }

  context 'unauthenticated customer' do
    let(:auth_token) { 'invalid' }

    it 'returns authentication error' do
      get '/api/accounts', headers: headers

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'authenticated user' do
    let(:auth_token) { AuthenticateCustomer.for(customer.slice(:email, :password)).data }

    it 'returns a list of customer accounts' do
      get '/api/accounts', headers: headers

      expect(response).to have_http_status(:ok)
    end

    it 'creates an account' do
      post '/api/accounts', headers: headers, params: {
        data: { iban: 'AT483200000012345864', currency: 'EUR' }
      }

      expect(response).to have_http_status(:created)
      expect(response.body).to include_json(
        data: { id: Account.last.id },
      )
    end

    context 'existing account' do
      let(:account) { create(:account, customer: customer) }

      it 'returns account data' do
        get "/api/accounts/#{account.id}", headers: headers

        expect(response).to have_http_status(:ok)
        expect(response.body).to include_json(
          data: { iban: account.iban },
        )
      end
    end
  end
end
