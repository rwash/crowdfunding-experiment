CrowdfundingExperiment::Application.routes.draw do

  root :to => "user_sessions#new"

  # Routes for USERS / USER_SESSIONS / PROJECTS
  resources :users, :only => [:create]  
  resources :user_sessions, :only => [:create, :destroy]
  post "/rounds/:id/create_projects" => "projects#create_projects", :as => :create_projects  
  match "welcome" => "experiments#welcome", :as => :welcome
    
  
  # Routes for EXPERIMENTS
  match "/experiments/:id/summary" => "experiments#summary", :as => :experiment_summary   
  match "/experiments/:id/status" => "experiments#status", :as => :experiment_status
  match "/experiments/:id/history_summary" => "experiments#history_summary", :as => :experiment_history_summary
  match "/experiments/:id/payouts" => "experiments#payouts", :as => :experiment_payouts
  match "/experiment_complete" => "experiments#complete", :as => :experiment_complete
  
   
  # Routes for ROUNDS
  resources :rounds, :only => [:create]
  match "/rounds/:id/waiting" => "rounds#waiting_for_round", :as => :round_waiting    
  match "/rounds/:id/waiting_for_part_b" => "rounds#waiting_for_part_b", :as => :waiting_for_part_b
  match "/rounds/:id/part_b" => "rounds#show_part_b", :as => :round_show_part_b
  match "/rounds/:id/creator_summary" => "rounds#creator_summary", :as => :creator_round_summary
  match "/rounds/:id/donor_summary" => "rounds#donor_summary", :as => :donor_round_summary
  match "/rounds/:id/summary/waiting" => "rounds#waiting_for_summary", :as => :summary_waiting     
  match "/rounds/:id/round_history" => "rounds#round_history", :as => :round_history
  match "/rounds/:id/countdown" => "rounds#countdown", :as => :countdown    
  match "/rounds/:id/update_donation_results" => "rounds#update_donation_results", :as => :update_donation_results    
         
   
  # Routes for GROUPS
  match "/rounds/:id/part_a1" => "groups#show_part_a1", :as => :round_show_part_a1 
  match "/rounds/:id/part_a2" => "groups#show_part_a2", :as => :round_show_part_a2  
                       

  # Routes for CONTRIBUTIONS
  resources :contributions, :only => [:create]
	match "/contributions/submit" => "contributions#submit"  
    
  
  # Routes for INSTRUCTIONS
	match "/instructions" => "users#instructions", :as => :instructions
	match "/instructions_iframe" => "users#instructions_iframe", :as => :instructions_iframe    
	
	
	# Routes for SURVEYS
  resources :surveys, :only => [:new, :create]


  # Routes for ACTIVE_ADMIN
  begin
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  rescue Exception => e
    puts "ActiveAdmin: #{e.class}: #{e}"
  end      

end      