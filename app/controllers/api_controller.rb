class APIController < ActionController::API
  before_action :authenticate_customer!

  rescue_from Paramore::NilParameter do
    render json: { errors: [_1.message] }, status: :bad_request
  end

  private

  def authenticate_customer!
    return if current_customer

    render json: { errors: ['Authentication required' ] }, status: :unauthorized
  end

  def current_customer
    @current_customer ||= AuthenticateToken.for(authorization_token)
  end

  def authorization_token
    request.headers['Authorization'].to_s.split(' ').last
  end
end
