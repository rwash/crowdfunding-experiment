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
		@projects = []
		4.times {|i| @projects << Project.create(:start_amount => PROJECT_START_AMOUNTS[i]) }
	end
	
	def submit
		if !current_user.question_1A.nil?
			flash[:error] = "You already answered the questions. (If you havn't talk to the admin.)"
			return redirect_to final_experiment_summary_path(current_experiment)
		end
		
		if (params[:question_1A].to_i + params[:question_1B].to_i) > 150 ||  params[:question_1A].to_i < 0 || params[:question_1B].to_i < 0
			flash[:error] = "Cannot give more then 150 credits for question 1."
			return redirect_to questions_path
		end
		
		if params[:question_1A].to_i >= 150
			current_user.payout += 150
		elsif params[:question_1B].to_i >= 150
			current_user.payout += 200
		elsif current_experiment.return_credits
			current_user.payout += 150
		else
			current_user.payout += (150 - params[:question_1A].to_i - params[:question_1B].to_i)
		end
	
		current_user.question_1A = params[:question_1A]
		current_user.question_1B = params[:question_1B]
		current_user.question_2A = params[:question_10]
		current_user.question_2B = params[:question_11]
		current_user.question_2C = params[:question_12]
		current_user.question_2D = params[:question_13]
		current_user.save!
		
		current_experiment.users.each do |u|
			if u.question_1A.nil?
				return redirect_to final_experiment_summary_path(current_experiment)
			end
		end
	
		current_experiment.finished = true
		current_experiment.end_time = Time.now
		current_experiment.save!
		
		redirect_to final_experiment_summary_path(current_experiment)
	end
end
