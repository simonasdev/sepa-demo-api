RSpec.describe 'Authentication' do
  it 'returns error for incorrect credentials' do
    post '/authentication', params: { email: 'email@mail.com', password: 'incorrect' }

    expect(response).to have_http_status(:unauthorized)
  end
end
