class SessionsController < InheritedResources::Base
	def create
		@session = Session.new(params[:session])
		
		3.times do
			@round = Round.create
			4.times do
				@round.projects << Project.create
			end
			@session.rounds << @round
		end
		
		
    if @session.save
      redirect_to @session
    else
    	flash[:error] = "Failed to create a new session."
    	redirect_to root_path
    end
	end
end
