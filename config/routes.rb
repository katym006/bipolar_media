Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root "articles#index"

  resources :articles, only: %i[index show]
  resources :screening_tests, only: %i[index show]
  resources :specialists, only: :index
  resources :mood_entries, only: %i[index new create]
end
