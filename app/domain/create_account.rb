class CreateAccount
  include Interactor::Initializer

  ResultStruct = Struct.new(:success?, :data)

  initialize_with :customer, :params

  def run
    return ResultStruct.new(false, errors) unless params_valid?

    account = customer.accounts.create!(params)

    ResultStruct.new(true, account)
  end

  private

  def iban
    params[:iban].presence
  end

  def currency
    params[:currency].presence
  end

  def params_valid?
    errors.push('Invalid iban') unless Ibandit::IBAN.new(iban).valid?
    errors.push('Missing currency') unless currency.present?

    errors.push('Account already exists') if Account.exists?(iban: iban)

    errors.empty?
  end

  def errors
    @errors ||= []
  end
end
