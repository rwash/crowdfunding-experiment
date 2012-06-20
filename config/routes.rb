CrowdfundingExperiment::Application.routes.draw do

	match "/instructions" => "users#instructions", :as => :instructions
	
	match "/questions" => "users#questions", :as => :questions
	match "/questions/submit" => "users#submit"
	
	match "contributions/submit" => "contributions#submit"
  match "/admin/login" => "admin#login"
  
  match "/rounds/:id/summary" => "rounds#summary", :as => :round_summary
  match "/experiments/:id/summary" => "experiments#summary", :as => :experiment_summary
  match "/experiments/:id/final-summary" => "experiments#final", :as => :final_experiment_summary
	
  resources :users
  resources :projects
  resources :rounds
  resources :experiments
  resources :preferences
  resource :user_sessions
  resources :contributions

  root :to => "user_sessions#new"
end
