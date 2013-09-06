HourLogger::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :user_hours
  resources :archives
  resources :mentors
  resources :approves

  devise_scope :user do 
    authenticated :user do
      root :to => 'mains#index'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new'
    end
  end

  devise_for :users, :controllers => { 
    sessions: "devise_overrides/sessions_overrides"
  }

  # auto completeroute
  get "user_hour/autocomplete" => 'user_hours#autocomplete_placement_name'
  ActiveAdmin.routes(self)
end