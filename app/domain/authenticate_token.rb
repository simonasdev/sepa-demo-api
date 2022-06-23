class AuthenticateToken
  include Interactor::Initializer

  initialize_with :token

  def run
    return unless payload = token_payload

    Customer.find(payload.fetch(:id))
  end

  private

  def token_payload
    payload = JWT.decode(token, Rails.application.secrets.secret_key_base)

    payload.first.with_indifferent_access if payload.is_a?(Array)
  rescue JWT::DecodeError
    nil
  end
end
