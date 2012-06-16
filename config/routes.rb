CrowdfundingExperiment::Application.routes.draw do
  resources :users
  resources :projects
  resources :rounds
  resources :sessions
  resources :preferences

  root :to => 'users#login'
end
