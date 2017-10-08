Rails.application.routes.draw do
  root "accounts#index"
  post "accounts/make_payment", controller: :accounts, action: :make_payment
  devise_for :users, controllers: {registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
