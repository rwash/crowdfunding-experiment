class UsersController < InheritedResources::Base
	def instructions
		@user = current_user
		
		@user.times_viewed_instructions = current_user.times_viewed_instructions + 1
		@user.save!
		
		@current_round = @user.experiment.current_round
	end
	
	def questions
		@user = current_user
	end
	
	def submit
		flash[:notice] = "You made it throught the question submit controller, but I didnt save anything."
		redirect_to final_experiment_summary_path(current_experiment)
	end
end
