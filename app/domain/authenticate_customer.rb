class AuthenticateCustomer
  include Interactor::Initializer

  ResultStruct = Struct.new(:success?, :data)

  initialize_with :email, :password

  def run
    return ResultStruct.new(false, ['Invalid credentials']) unless credentials_valid?

    ResultStruct.new(true, token)
  end

  private

  def credentials_valid?
    customer&.authenticate(password)
  end

  def customer
    @customer ||= Customer.find_by(email: email)
  end

  def token
    JWT.encode({
      id: customer.id,
      exp: 1.day.from_now.to_i,
    }, Rails.application.secrets.secret_key_base)
  end
end
