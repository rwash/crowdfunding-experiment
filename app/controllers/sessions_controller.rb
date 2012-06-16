class SessionsController < InheritedResources::Base
	def create
		@session = Session.new(params[:session])

    if @session.save
      redirect_to @session
    else
    	flash[:error] = "Failed to create a new session."
    	redirect_to root_path
    end
	end
end
