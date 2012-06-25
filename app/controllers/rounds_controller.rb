class RoundsController < InheritedResources::Base
	def summary
		@current_round = Round.find(params[:id])
		@user = current_user
		@preferences = Preferences.where(:user_id => @user.id, :round_id => @current_round.id).first
		@next_round = Round.where(:id => @current_round.id + 1).first
		@projects = Project.where(:round_id => @current_round.id)
		
		#current_experiment.current_round = @next_round
		#current_experiment.save!
	end
	
	def show
		@current_round =  Round.find(params[:id])
		@user = current_user
		@preferences = Preferences.where(:user_id => @user.id, :round_id => @current_round.id).first unless @user.name == 'admin'
		@projects = Project.where(:round_id => @current_round.id)
	end
	
	def waiting_for_summary
		@current_round = Round.find(params[:id])
		if @current_round.finished
			@current_round.round_over
			if last_round?(@current_round)
				current_experiment.experiment_over
			end
			redirect_to round_summary_path(@current_round)
		end
	end
	
	def waiting_for_round
		@current_round = Round.find(params[:id])
		@pref = Preferences.where(:user_id => current_user.id, :round_id => @current_round.id).first if @pref.nil?
		@pref.ready_save_and_check_round unless @pref.ready_to_start
		
		if @current_round.started
			current_experiment.start_experiment unless current_experiment.started
			# current_experiment.current_round = @current_round
			current_experiment.save!
					
			@current_round.round_started
			redirect_to round_path(@current_round)
		end
	end
end
