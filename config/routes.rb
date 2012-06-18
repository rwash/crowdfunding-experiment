CrowdfundingExperiment::Application.routes.draw do
  resources :users
  resources :projects
  resources :rounds
  resources :sessions
  resources :preferences
  resource :user_sessions
  resources :contributions
  
  match "/instructions" => "users#instructions", :as => :instructions
  
  match "/admin/login" => "admin#login"
  root :to => "user_sessions#new"
end
