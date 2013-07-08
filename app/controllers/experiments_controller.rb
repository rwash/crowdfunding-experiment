class ExperimentsController < InheritedResources::Base


	def summary
		@user = current_user
    @experiment = @user.experiment
    @survey = @user.survey     
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
	  @total_return_in_dollars = 0
	  @experiment.users.each do |user|
	    @total_return += user.total_return if user.total_return
	    @total_return_in_dollars += user.total_return_in_dollars if user.total_return_in_dollars
	  end    	 
	end      
	
	
	def complete
	 @user = current_user
	end

end
