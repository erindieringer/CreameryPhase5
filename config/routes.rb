Rails.application.routes.draw do
  # Routes for main resources
  resources :stores
  resources :employees
  resources :assignments
  resources :shifts
  resources :flavors
  resources :jobs
  resources :users
  resources :shift_jobs
  resources :store_flavors
  resources :sessions

  get 'logout' => 'sessions#destroy', as: :logout
  get 'login' => 'sessions#new', as: :login

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

  get 'complete' => 'shifts#complete', as: :complete
  get 'start_now' => 'shifts#start_now', as: :start_now
  get 'end_now' => 'shifts#end_now', as: :end_now
  # Set the root url
  root :to => 'home#home'  
  
end
