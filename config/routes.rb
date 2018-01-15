Rails.application.routes.draw do
  namespace :api do
    resources :events, only: [:index]
  end
end
