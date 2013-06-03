class UsersController < InheritedResources::Base
	def instructions
		@user = current_user
		@user.times_viewed_instructions = current_user.times_viewed_instructions + 1
		@user.save!

		if !current_experiment.started
			current_experiment.start_time = DateTime.now
			current_experiment.save!
		end
		
    @first_round = Round.where(:group_id => @user.group_id, :number => 1).first
    @current_round = current_round

    # @current_round = current_experiment.rounds.where(:number => current_experiment.current_round_number, :group_id => @user.group_id).first
    # 
    # @temp_rounds = current_experiment.rounds.where(:number => 1)
    # @first_round = nil
    # unless @temp_rounds.nil?
    #   if @user.preferences.where(:round_id => @temp_rounds.first.id).first.nil?
    #     @first_round = @temp_rounds.last
    #   else
    #     @first_round = @temp_rounds.first
    #   end
    # end
	end
	
	
	def instructions_iframe
		current_user.times_viewed_instructions = current_user.times_viewed_instructions + 1
		current_user.save!
	end
	
	
	def questions
		@user = current_user
		@projects = []
		4.times {|i| @projects << Project.create(:start_amount => PROJECT_START_AMOUNTS[i]) }
	end
	
	
	def submit
		if params[:question_1A][0] == '' || params[:question_1B][0] == ''
			flash[:error] = "Cannot leave question one blank."
			return redirect_to questions_path
		end
		
		if !current_user.question_1A.nil?
			flash[:error] = "You already answered the questions. (If you havn't talk to the admin.)"
			return redirect_to final_experiment_summary_path(current_experiment)
		end
		
		if params[:question_1A] == "" || params[:question_1A].nil?
			@amountA = 0
		else
			@amountA = params[:question_1A].to_i
		end
		
		if params[:question_1B] == "" || params[:question_1B].nil?
			@amountB = 0
		else
			@amountB = params[:question_1B].to_i
		end
		
		if (@amountA + @amountB) > 150 ||  @amountA < 0 || @amountB < 0
			flash[:error] = "Cannot give more then 150 credits for question 1."
			return redirect_to questions_path
		end
		
		if @amountA >= 150
			current_user.questions_payout = 150
			current_user.payout += 150
		elsif @amountB >= 150
			current_user.questions_payout = 200
			current_user.payout += 200
		elsif current_experiment.return_credits
			current_user.questions_payout = 150
			current_user.payout += 150
		else
			current_user.payout += (150 - @amountA - @amountB)
			current_user.questions_payout = (150 - @amountA - @amountB)
		end
	
		current_user.question_1A = params[:question_1A]
		current_user.question_1B = params[:question_1B]
		current_user.question_2A = params[:question_20]
		current_user.question_2B = params[:question_21]
		current_user.question_2C = params[:question_22]
		current_user.question_2D = params[:question_23]
		current_user.save!
		
		current_experiment.users.each do |u|
			if u.question_1A.nil?
				return redirect_to final_experiment_summary_path(current_experiment)
			end
		end
	
		current_experiment.finished = true
		current_experiment.end_time = DateTime.now
		current_experiment.save!
		
		redirect_to final_experiment_summary_path(current_experiment)
	end
end
