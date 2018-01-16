Rails.application.routes.draw do
  root 'pages#index'

  namespace :api do
    resources :events, only: [:index]
  end
end
