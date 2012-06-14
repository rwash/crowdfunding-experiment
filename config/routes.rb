CrowdfundingExperiment::Application.routes.draw do
  resources :projects

  resources :rounds

  resources :sessions

  root :to => 'sessions#index'
end
