Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks, only:[:index,:new, :create, :edit, :update, :show, :destroy]
  resources :users, only: [:new, :create]
  # resources :tasks
end
