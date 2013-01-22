HourLogger::Application.routes.draw do

  devise_for :users

  resources :user_hours

  root :to => 'mains#index'

end
