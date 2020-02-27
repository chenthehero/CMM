Rails.application.routes.draw do
  resources :task_entries
  resources :tasks
  devise_for :users
  resources :projects
  resources :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'projects#index'
end
