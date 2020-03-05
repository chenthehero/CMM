Rails.application.routes.draw do
  resources :task_entries
  resources :tasks
  devise_for :users
  resources :projects
  resources :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  patch ':id/start_time', to: 'task_entries#start_time', :as => 'start_time'
  patch ':id/stop_time', to: 'task_entries#stop_time', :as => 'stop_time'

  root 'task_entries#index'
end
