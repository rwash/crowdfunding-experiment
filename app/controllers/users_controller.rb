class UsersController < InheritedResources::Base
  
	def instructions
		@user = current_user
		@user.user_viewed_instructions
    @current_round = current_round
    
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
