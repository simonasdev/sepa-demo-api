class API::AuthenticationsController < APIController
  skip_before_action :authenticate_customer!

  param_schema :authentication_params,
    data: Paramore.field(
      email: Paramore.field(Paramore::SanitizedString),
      password: Paramore.field(Paramore::SanitizedString),
    )

  def create
    result = AuthenticateCustomer.for(
      authentication_params[:email],
      authentication_params[:password]
    )

    if result.success?
      render json: { data: result.data }, status: :created
    else
      render json: { errors: result.data }, status: :unauthorized
    end
  end
end
