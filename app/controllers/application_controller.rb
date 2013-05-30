# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user, :current_experiment, :current_group, :last_round
  # filter_parameter_logging :password, :password_confirmation
  
  private
  
    def check_if_user_and_round_ready(preference, current_round)
      @preference = preference
      if !@preference.is_ready
        @preference.is_ready = true
        @preference.save!
        current_round.check_if_round_ready_to_start
      end    
    end
  
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
    
    
    def check_round(round, user)
      @round = round
      @user = user
      
      # Check if user exists        <TODO CL> Tidy this up
    	if @user
    	  # Check if User belongs to this Round as a Creator
    	  if CreatorPreference.where(:round_id => @round.id, :user_id => @user.id).first.nil?
    	    # If not, check if User belongs to this Round as a Donror
    	    if DonorPreference.where(:round_id => @round.id, :user_id => @user.id).first.nil?
      		  flash[:error] = "Not allowed to view round you dont belong to."
            return redirect_to root_path
          end
        end
      else
        flash[:error] = "Not logged in."
        return redirect_to root_path
    	end
    	
    	if @user.nil? || @round.part_a_started == false
    		flash[:error] = "Not allowed to view round that hasn't started."
        return redirect_to round_waiting_path(@round)
    	end
    	
    	if @user.nil? || @round.part_b_finished == true
    		flash[:error] = "Round has finished."
    		return redirect_to summary_waiting_path(@round)
    	end
    	
    end
    
end