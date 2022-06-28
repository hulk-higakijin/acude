Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  devise_for :accounts
  resources :universities, only: [:index, :show]
  resources :profiles, only: [:create, :new, :edit, :update]
end
