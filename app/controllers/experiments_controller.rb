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
    @rounds = @user.group.rounds
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


  # def index     <TODO CL> Remove?
  #   require_admin
  #   @experiments = Experiment.all
  # end
  
  # def users     <TODO CL> Remove?
  #   @experiment = Experiment.find(params[:id])
  # end
	
  # def dashboard     <TODO CL> Remove?
  #   require_admin
  #   @experiment = Experiment.find(params[:id])
  #   @roundsA = @experiment.groups.first.rounds.where(:number => (1..@experiment.current_round_number)).order("number DESC")
  #   @roundsB = @experiment.groups.last.rounds.where(:number => (1..@experiment.current_round_number)).order("number DESC")
  #   
  #   if @roundsA.first.finished and @roundsB.first.finished
  #     @roundsA = @experiment.groups.first.rounds.where(:number => (1..@experiment.current_round_number + 1)).order("number DESC")
  #     @roundsB = @experiment.groups.last.rounds.where(:number => (1..@experiment.current_round_number + 1)).order("number DESC")
  #   end
  # end
	
  # def new     <TODO CL> Remove?
  #   require_admin
  #   @experiment = Experiment.new
  # end

end
