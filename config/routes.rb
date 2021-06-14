Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  root "welcome#index"
  resource :user, only: %i[show update], controller: :user
  resources :transactions
  resources :accounts
  resources :categories
  resources :areas
  resources :analytics, only: :index do
    collection do
      resources :categories, except: :index
      resources :areas, except: :index
    end
  end
  resources :currencies, except: %i[edit update]
  devise_for :users, controllers: {passwords: 'passwords'}, defaults: {format: :json}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
