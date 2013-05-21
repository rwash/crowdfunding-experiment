CrowdfundingExperiment::Application.routes.draw do

  root :to => "user_sessions#new"

  # Routes for USERS / PROJECTS / USER_SESSIONS
  resources :users, :only => [:create]  
  resources :projects, :only => [:create]
  resource :user_sessions, :only => [:create, :destroy]
    
  
  # Routes for EXPERIMENTS
  resources :experiments, :only => [:new, :create, :index]
  match "/experiments/:id/admin" => "experiments#dashboard", :as => :dashboard
  match "/experiments/:id/users" => "experiments#users", :as => :experiment_users
  match "/experiments/:id/summary" => "experiments#summary", :as => :experiment_summary
  match "/experiments/:id/final-summary/waiting" => "experiments#waiting_for_summary", :as => :experiment_summary_waiting
  match "/experiments/:id/final-summary" => "experiments#final_summary", :as => :final_experiment_summary  
  
   
  # Routes for ROUNDS
  resources :rounds, :only => [:create, :show]
  match "/rounds/:id/summary" => "rounds#summary", :as => :round_summary
  match "/rounds/:id/summary/waiting" => "rounds#waiting_for_summary", :as => :summary_waiting
  match "/rounds/:id/waiting" => "rounds#waiting_for_round", :as => :round_waiting  
   
  
  # Routes for CONTRIBUTIONS
  resources :contributions, :only => [:create]
	match "/contributions/submit" => "contributions#submit"  
  
    	
  # Routes for QUESTIONS
	match "/questions" => "users#questions", :as => :questions
	match "/questions/submit" => "users#submit"  
    
  
  # Routes for INSTRUCTIONS
	match "/instructions" => "users#instructions", :as => :instructions
	match "/instructions_iframe" => "users#instructions_iframe", :as => :instructions_iframe  
  
    
  # Routes for PREFERENCES
  resources :preferences, :only => [:create]
	match "/preferences/:id/flag" => "preferences#flag", :as => :flag_user
	match "/preferences/submit-flag" => "preferences#flag_submit"
	match "/preferences/:id/unflag" => "preferences#unflag", :as => :unflag_user  


  # Routes for ACTIVE_ADMIN
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

end