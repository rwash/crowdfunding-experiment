class ExperimentsController < InheritedResources::Base


	def summary     # <TODO CL> Finish.
		@user = current_user
    @experiment = @user.experiment
	end

end
