Rails.application.routes.draw do
  namespace :api do
    resource :authentication, only: [:create]

    resources :customers, only: [:create]
    resources :payment_orders, only: [:index, :create, :show]
    resources :accounts, only: [:index, :create, :show]
  end
end
