Rails.application.routes.draw do
  root "transactions#index"
  get 'transactions/index'
  get 'transactions/new'
  get 'transactions/edit'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
