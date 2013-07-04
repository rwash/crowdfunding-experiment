class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session
  helper_method :current_user
  helper_method :current_experiment     
  helper_method :current_round
  helper_method :last_round    
  helper_method :generate_project_name
  
  
  private
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    
    def current_experiment
    	return @current_experiment if defined?(@current_experiment)
    	@current_experiment = current_user.experiment
    end
    
    
    def current_round
      @experiment = current_experiment
      Round.where(:experiment_id => @experiment.id).order("number ASC").each do |round|
        return round unless round.round_complete
      end 
      return @experiment.rounds.first
    end   
    
    
    def set_user_status(user, status)
      user.status = status
      user.save!
    end  
         
    
    def generate_project_name
  		@project_name = $project_names[0]
  		$project_names.delete($project_names[0])

  		# if we run out of names refill the array again
  		if $project_names == []
  			reseed_names
  		end
      return @project_name
  	end      


  	def reseed_names
  		require 'csv'
  		$project_names = []
  		CSV.foreach("colors4.csv", :headers => false) do |row|
  		  $project_names << row[0]
  		end

  		$project_names.each do |n|
  			n.gsub!(";",'')
  		end 
  	end
    
end