Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root to: "dashboard#show"
  end

  get "up" => "rails/health#show", as: :rails_health_check

  resources :mood_entries
  resources :articles
  resources :trusted_contacts, only: [:index]
  resources :test_attempts, only: [:index, :show]
  resources :recommendations, only: [:index]
  resources :screening_tests
  resources :specialists
  get "about", to: "home#about", as: :about
  root "home#index"
end
