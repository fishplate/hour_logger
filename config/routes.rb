HourLogger::Application.routes.draw do

  devise_for :users

  resources :user_hours
  resources :archives

  root :to => 'mains#index'

  # auto completeroute
  get "user_hour/autocomplete" => 'user_hours#autocomplete_placement_name'
end
