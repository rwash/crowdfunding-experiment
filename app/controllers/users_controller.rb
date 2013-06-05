class UsersController < InheritedResources::Base
  
	def instructions
		@user = current_user
		@user.user_viewed_instructions
    if current_round
      @current_round = current_round
    else
      @current_round = Round.where(:group_id => @user.group_id, :number => 1)
    end
    
		if !current_experiment.started
			current_experiment.start_time = DateTime.now
			current_experiment.save!
		end
	end
	
	
	def instructions_iframe
		@user = current_user
		@user.user_viewed_instructions
	end

end
