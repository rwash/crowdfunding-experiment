class RoundsController < InheritedResources::Base
	def summary
		@current_round = Round.find(params[:id])
		@user = current_user
		@preferences = Preferences.where(:user_id => @user.id, :round_id => @current_round.id).first
		@contributions = Contribution.where(:user_id => current_user.id, :round_id => @current_round.id)
		
		@not_donated = AMOUNT_USER_CAN_DONATE_PER_ROUND
		@contributions.each do |c|
			@not_donated = @not_donated - c.amount
		end
		
		@temp_rounds = current_experiment.rounds.where(:number => @current_round.number + 1)
		@next_round = nil
		unless @temp_rounds.first.nil?
			if @user.preferences.where(:round_id => @temp_rounds.first.id).first.nil?
				@next_round = @temp_rounds.last
			else
				@next_round = @temp_rounds.first
			end
		end
	
		@projects = Project.where(:round_id => @current_round.id)
	end
	
	def show
		@current_round =  Round.find(params[:id])
		check_round(@current_round)
		@user = current_user
		@preferences = Preferences.where(:user_id => @user.id, :round_id => @current_round.id).first unless @user.name == 'admin'
		@projects = Project.where(:round_id => @current_round.id).order('id ASC')
	end
	
	def waiting_for_summary
		@current_round = Round.find(params[:id])
		
		if !@current_round.finished && current_user.id == @current_round.users.first.id
			@current_round.check_if_all_done
		end
		
		if current_experiment.rounds.where(:number => @current_round.number).first.finished && current_experiment.rounds.where(:number => @current_round.number).last.finished # TODO this line is really bad	
		
			if last_round?(@current_round)
				current_experiment.experiment_over if current_user == current_experiment.users.first # a cheap way to make sure it only happens once
			end
			
			redirect_to round_summary_path(@current_round)
		end
	end
	
	def waiting_for_round
		@current_round = Round.find(params[:id])
		unless current_user.group_id == @current_round.group_id
			current_user.group_id = @current_round.group_id
			current_user.save!
		end
		
		@pref = Preferences.where(:user_id => current_user.id, :round_id => @current_round.id).first if @pref.nil?
		@pref.ready_save_and_check_round unless @pref.ready_to_start
		
		if current_experiment.rounds.where(:number => @current_round.number).first.started && current_experiment.rounds.where(:number => @current_round.number).last.started # TODO this line is really bad
			current_experiment.start_experiment unless current_experiment.started
			current_experiment.current_round_number = @current_round.number
			current_experiment.save!
					
			@current_round.round_started
			redirect_to round_path(@current_round)
		end
	end
end
