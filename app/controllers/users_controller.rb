class UsersController < InheritedResources::Base
	def instructions
		@user = current_user
		
		if !current_experiment.started
			current_experiment.start_time = Time.now
			current_experiment.save!
		end
		
		@user.times_viewed_instructions = current_user.times_viewed_instructions + 1
		@user.save!
		
		@first_round = @user.experiment.current_round
	end
	
	def questions
		@user = current_user
	end
	
	def submit
		current_user.response_one = params[:question_1]
		current_user.response_two = params[:question_2]
		current_user.save!
		
		current_experiment.users.each do |u|
			if u.response_one.nil? || u.response_two.nil?
				return redirect_to final_experiment_summary_path(current_experiment)
			end
		end
	
		current_experiment.finished = true
		current_experiment.end_time = Time.now
		current_experiment.save!
		
		redirect_to final_experiment_summary_path(current_experiment)
	end
end
