RSpec.describe 'Customers' do
  it 'returns error for missing data' do
    post '/api/customers', params: { data: { email: '', password: '', full_name: '' } }

    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'returns created customer' do
    post '/api/customers', params: {
      data: { email: 'valid@mail.com', password: 'secret', full_name: 'Customer' }
    }

    expect(response).to have_http_status(:created)
    expect(response.body).to include_json(data: { id: Customer.last.id })
  end
end
