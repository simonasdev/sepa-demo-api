class CreatePaymentOrder
  include Interactor::Initializer

  ResultStruct = Struct.new(:success?, :data)

  initialize_with :customer, :params

  def run
    return ResultStruct.new(false, errors) unless params_valid?

    payment_order = customer.issued_payment_orders.create!(
      receiver: receiver,
      amount: amount,
      status: :pending
    )

    ProcessPaymentOrderJob.perform_later(payment_order.id)

    ResultStruct.new(true, payment_order)
  end

  private

  def receiver
    if iban
      Account.find_by(iban: iban).customer
    else
      Customer.find_by(full_name: full_name)
    end
  end

  def iban
    params[:iban].presence
  end

  def full_name
    params[:full_name].presence
  end

  def amount
    params[:amount].to_i
  end

  def params_valid?
    # firstly search by iban, then by full name
    if iban
      ibandit = Ibandit::IBAN.new(iban)

      if ibandit.valid?
        errors.push('Account not found') unless Account.exists?(iban: iban)
      else
        ibandit.errrors.values.each { errors.push(_1) }
      end
    end

    if full_name
      errors.push('Receiver not found') unless Customer.exists?(full_name: full_name)
    end

    # no receiver data provided
    if !full_name && !iban && errors.empty?
      errors.push('No receiver data provided')
    end

    if amount <= 0
      errors.push('Incorrect amount')
    end

    # also would need to validate customer's account balance
    errors.empty?
  end

  def errors
    @errors ||= []
  end
end
