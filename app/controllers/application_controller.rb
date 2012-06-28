# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user, :current_experiment, :current_group, :last_round
  # filter_parameter_logging :password, :password_confirmation
  
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
    
    def current_group
    	return @group if defined?(@group)
    	@group = Group.find(current_user.group_id) unless current_user.name == 'admin'
    end
    
    def last_round?(round)
	    	round == round.group.rounds.last
		end
    
    def require_admin
      if current_user.nil? || current_user.name != 'admin'
        flash[:error] = "You must be logged in as an admin to access this page."
        return redirect_to root_path
      end
    end
    
    def check_round(round)
    	if current_user.nil? || Preferences.where(:round_id => round.id, :user_id => current_user.id).first.nil?
    		flash[:error] = "Not allowed to view round you dont belong to."
        return redirect_to root_path
    	end
    	if current_user.nil? || round.started == false
    		flash[:error] = "Not allowed to view round that hasn't started."
        return redirect_to root_path
    	end
    end
end