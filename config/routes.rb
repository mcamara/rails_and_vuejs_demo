Rails.application.routes.draw do
  root 'pages#index'

  namespace :api do
    resources :events, only: [:index]
    resources :categories, only: [:index]
  end
end
