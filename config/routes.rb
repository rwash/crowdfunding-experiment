CrowdfundingExperiment::Application.routes.draw do

	match "/instructions" => "users#instructions", :as => :instructions
	match "/instructions_iframe" => "users#instructions_iframe", :as => :instructions_iframe
	
	match "/questions" => "users#questions", :as => :questions
	match "/questions/submit" => "users#submit"
	
	match "/preferences/:id/flag" => "preferences#flag", :as => :flag_user
	match "/preferences/:id/unflag" => "preferences#unflag", :as => :unflag_user
	
	match "/contributions/submit" => "contributions#submit"
	  
  match "/rounds/:id/summary" => "rounds#summary", :as => :round_summary
  match "/rounds/:id/summary/waiting" => "rounds#waiting_for_summary", :as => :summary_waiting
  match "/rounds/:id/waiting" => "rounds#waiting_for_round", :as => :round_waiting
  
  match "/experiments/:id/admin" => "experiments#dashboard", :as => :dashboard
  match "/experiments/:id/users" => "experiments#users", :as => :experiment_users
  match "/experiments/:id/summary" => "experiments#summary", :as => :experiment_summary
  match "/experiments/:id/final-summary/waiting" => "experiments#waiting_for_summary", :as => :experiment_summary_waiting
  match "/experiments/:id/final-summary" => "experiments#final_summary", :as => :final_experiment_summary
  
  resources :users, :only => [:create]
  resources :projects, :only => [:create]
  resources :rounds, :only => [:create, :show]
  resources :experiments, :only => [:new, :create, :index]
  resources :preferences, :only => [:create]
  resource :user_sessions, :only => [:create, :destroy]
  resources :contributions, :only => [:create]

  root :to => "user_sessions#new"
end
