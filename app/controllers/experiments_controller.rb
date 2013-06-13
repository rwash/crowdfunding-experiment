class ExperimentsController < InheritedResources::Base

  def new_round
    @experiment = current_experiment
    @current_round = current_round
    @experiment.start_experiment unless @experiment.started
    @experiment.set_current_round(@current_round)
    redirect_to round_waiting_path(@current_round)
  end


	def summary
		@user = current_user
    @rounds = current_experiment.rounds
    # <TODO CL>  Add Round Payout Calculation Here
	end
	
	
	def waiting_for_summary
		if current_experiment.finished_calc
			redirect_to experiment_summary_path(current_experiment)
		end
	end


	def final_summary       # <TODO CL> Revise
		@user = current_user
		@preferences = @user.preferences
		@preferences.sort! {|a,b| Round.find(a.round_id).number <=> Round.find(b.round_id).number}
	end	    

end
