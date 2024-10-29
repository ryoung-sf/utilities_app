Rails.application.routes.draw do
  resources :meters, only: %i[index]
  devise_for :users
  
  authenticated :user do
    root to: "meters#index", as: :authenticated_user_root do
      resources :bills, only: %i[index]
      resources :readings, only: %i[index]
      
    end
    
    get "meters/dates", to: "meters#statement_date"
    get "meters/historical_collection", to: "meters#historical_collection"
  end
  
  resources :request_forms, only: %i[new create url]
  get "request_forms/url", to: "request_forms#url", as: :url_request_form
  get 'authorizations/receive', to: "authorizations#receive"

  namespace :webhooks do
    resource :utility_api, controller: :utility_api, only: [:create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  mount GoodJob::Engine, at: "good_job"
  
  # get 'static_pages/index'
  # Defines the root path route ("/")
  root "static_pages#index"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/products", to: "static_pages#products"
  get "/features", to: "static_pages#features"
end
