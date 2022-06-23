RSpec.describe 'Authentication' do
  let(:customer) { create(:customer) }

  it 'returns error for incorrect credentials' do
    post '/api/authentication', params: { data: { email: customer.email, password: 'incorrect' } }

    expect(response).to have_http_status(:unauthorized)
  end

  it 'returns auth token for correct credentials' do
    post '/api/authentication', params: { data: { email: customer.email, password: 'secret' } }

    expect(response).to have_http_status(:created)
    expect(JSON.parse(response.body)).to include('data' => String)
  end
end
