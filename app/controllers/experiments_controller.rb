class ExperimentsController < InheritedResources::Base


	def summary     # <TODO CL> Finish.
		@user = current_user
    @experiment = @user.experiment     
    
    set_user_status(@user, "Viewing Experiment Summary") 	 	 
	end               
	
	
	def status
	  @experiment = Experiment.find(params[:id])
	end      
	
	
	def history_summary
	  @experiment = Experiment.find(params[:id]) 
	  @completed_rounds = @experiment.rounds.where(:round_complete => true) 
	end    
	
	
	def payouts
	  @experiment = Experiment.find(params[:id])  
	  @total_return = 0
	  @total_return_in_cents = 0
	  @experiment.users.each do |user|
	    @total_return += user.total_return if user.total_return
	    @total_return_in_cents += user.total_return_in_cents if user.total_return_in_cents
	  end    	 
	end

end
