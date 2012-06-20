CrowdfundingExperiment::Application.routes.draw do

	match "/instructions" => "users#instructions", :as => :instructions
	
	match "/questions" => "users#questions", :as => :questions
	match "/questions/submit" => "users#submit"
	
	match "contributions/submit" => "contributions#submit"
  match "/admin/login" => "admin#login"
  
  
  match "/rounds/:id/summary" => "rounds#summary", :as => :round_summary
  match "/rounds/:id/summary/waiting" => "rounds#waiting_for_summary", :as => :summary_waiting
  match "/rounds/:id/waiting" => "rounds#waiting_for_round", :as => :round_waiting
  
  match "/experiments/:id/summary" => "experiments#summary", :as => :experiment_summary
  match "/experiments/:id/final-summary/waiting" => "experiments#waiting_for_summary", :as => :experiment_summary_waiting
  match "/experiments/:id/final-summary" => "experiments#final_summary", :as => :final_experiment_summary
  
  resources :users
  resources :projects
  resources :rounds
  resources :experiments
  resources :preferences
  resource :user_sessions
  resources :contributions
  # we want to cut these down to only the ones we need

  root :to => "user_sessions#new"
end
