Rails.application.routes.draw do
  # Routes for main resources
  resources :stores
  resources :employees
  resources :assignments
  resources :shifts
  resources :flavors
  resources :jobs

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  
  # Set the root url
  root :to => 'home#home'  
  
end
