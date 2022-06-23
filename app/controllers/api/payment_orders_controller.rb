class API::PaymentOrdersController < APIController
  def index
    render json: { data: current_customer.payment_orders }
  end

  param_schema :payment_order_params,
    data: Paramore.field(
      full_name: Paramore.field(Paramore::SanitizedString, null: true),
      iban: Paramore.field(Paramore::SanitizedString, null: true),
      amount: Paramore.field(Paramore::SanitizedString)
    )
  def create
    result = CreatePaymentOrder.for(current_customer, payment_order_params)

    if result.success?
      render json: { data: result.data }, status: :created
    else
      render json: { errors: result.data }, status: :unprocessable_entity
    end
  end

  def show
    render json: { data: current_customer.payment_orders.find(params[:id]) }
  end
end
