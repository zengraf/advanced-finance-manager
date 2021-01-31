Rails.application.routes.draw do
  root "welcome#index"
  resources :transactions
  resources :accounts
  resources :analytics, only: :index do
    collection do
      resources :categories, except: :index
      resources :areas, except: :index
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
