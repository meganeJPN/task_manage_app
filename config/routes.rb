Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks, only:[:new, :create, :edit, :show, :destroy]
end
