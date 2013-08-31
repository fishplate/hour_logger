HourLogger::Application.routes.draw do

  devise_for :users

  resources :user_hours
  resources :archives
  resources :mentors

  devise_scope :user do 
    authenticated :user do
      root :to => 'devise/registrations#edit'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new'
    end
    
end

  # auto completeroute
  get "user_hour/autocomplete" => 'user_hours#autocomplete_placement_name'
end
