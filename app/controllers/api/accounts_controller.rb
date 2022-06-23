class API::AccountsController < APIController
  def index
    render json: { data: current_customer.accounts }
  end

  param_schema :account_params,
    data: Paramore.field(
      iban: Paramore.field(Paramore::SanitizedString),
      currency: Paramore.field(Paramore::SanitizedString),
    )
  def create
    result = CreateAccount.for(current_customer, account_params)

    if result.success?
      render json: { data: result.data }, status: :created
    else
      render json: { errors: result.data }, status: :unprocessable_entity
    end
  end

  def show
    render json: { data: current_customer.accounts.find(params[:id]) }
  end
end
