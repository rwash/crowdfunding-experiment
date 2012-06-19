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
		# save answers to questions and redirect to lime think
		
		#but for now
		flash[:notice] = "You made it throught the question submit controller."
		redirect_to root_path
	end
end
