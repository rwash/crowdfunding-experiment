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
end
