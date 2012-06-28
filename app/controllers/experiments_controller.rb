class ExperimentsController < InheritedResources::Base
	def create
		require_admin
		@experiment = Experiment.new(params[:experiment])
		
    if @experiment.save
      redirect_to dashboard_path(@experiment)
    else
    	flash[:error] = "Failed to create a new experiment."
    	redirect_to experiments_path
    end
	end
	
	def users
		@experiment = Experiment.find(params[:id])
	end
	
	def summary
		@user = current_user
	end
	
	def final_summary
		@user = current_user
	end
	
	def waiting_for_summary
		if current_experiment.finsihed_calc
			redirect_to experiment_summary_path(current_experiment)
		end
	end
	
	def dashboard
		require_admin
		@experiment = Experiment.find(params[:id])
		@roundsA = @experiment.groups.first.rounds.order("number DESC")
		@roundsB = @experiment.groups.last.rounds.order("number DESC")
	end
	
	def new
		require_admin
		@experiment = Experiment.new
	end
	
	def index
		require_admin
		@experiments = Experiment.all
	end
end
