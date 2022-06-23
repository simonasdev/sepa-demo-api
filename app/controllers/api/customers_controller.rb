class API::CustomersController < APIController
  skip_before_action :authenticate_customer!

  param_schema :customer_params,
    data: Paramore.field(
      full_name: Paramore.field(Paramore::SanitizedString),
      email: Paramore.field(Paramore::SanitizedString),
      password: Paramore.field(Paramore::SanitizedString),
    )
  def create
    result = CreateCustomer.for(customer_params)

    if result.success?
      render json: { data: result.data }, status: :created
    else
      render json: { errors: result.data }, status: :unprocessable_entity
    end
  end
end
