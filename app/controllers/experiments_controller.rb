class ExperimentsController < InheritedResources::Base
	def create
		@experiment = Experiment.new(params[:session])

    if @experiment.save
      redirect_to @experiment
    else
    	flash[:error] = "Failed to create a new session."
    	redirect_to experiments_path
    end
	end
	
	def summary
		@user = current_user
	end
	
	def final_summary
		@user = current_user
	end
	
	def waiting_for_summary
		if current_experiment.finished
			redirect_to experiment_summary_path(current_experiment)
		end
	end
end
