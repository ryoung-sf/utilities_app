Rails.application.routes.draw do
  get 'meters/index'
  devise_for :users
  
  authenticated :user do
    root to: "billing_accounts#index", as: :authenticated_user_root
  end
  
  # resources :billing_accounts, only: %i[index]
  resources :request_forms, only: %i[new create url]
  get "request_forms/url", to: "request_forms#url", as: :url_request_form
  get 'authorizations/receive', to: "authorizations#receive"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  mount GoodJob::Engine, at: "good_job"
  
  # get 'static_pages/index'
  # Defines the root path route ("/")
  root "static_pages#index"
end
