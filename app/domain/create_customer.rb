class CreateCustomer
  include Interactor::Initializer

  ResultStruct = Struct.new(:success?, :data)

  initialize_with :params

  def run
    return ResultStruct.new(false, errors) unless params_valid?

    customer = Customer.create!(params)

    ResultStruct.new(true, customer)
  end

  private

  def email
    params[:email].presence
  end

  def password
    params[:password].presence
  end

  def full_name
    params[:full_name].presence
  end

  def params_valid?
    errors.push('Invalid email') unless email&.match(URI::MailTo::EMAIL_REGEXP)
    errors.push('Missing password') unless password.present?
    errors.push('Missing full name') unless full_name.present?

    errors.push('Customer already exists') if Customer.exists?(email: email)

    errors.empty?
  end

  def errors
    @errors ||= []
  end
end
