CrowdfundingExperiment::Application.routes.draw do
  resources :users

  resources :projects

  resources :rounds

  resources :sessions

  root :to => 'users#login'
end
