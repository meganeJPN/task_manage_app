Rails.application.routes.draw do
  get 'sessions/new'
  root 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks, only:[:index,:new, :create, :edit, :update, :show, :destroy]
  resources :users, only: [:new, :create, :show]
  namespace :admin do
    resources :users
  end
end
