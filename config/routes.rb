Rails.application.routes.draw do
  root 'home#index'
  devise_for :accounts
  resources :universities, only: [:index, :show]
end
