class ContributionsController < InheritedResources::Base
	def create
		@contribution = Contribution.create(params[:contribution])
    if @contribution.save
	    flash[:notice] = "Contribution Successfull"
	  else
	  	flash[:error] = "FAILED to Contribute"
	  end
	  redirect_to new_contribution_path
	end
	
	# creates all contributions at the end of a round
	def submit
		@round = Round.find(params[:current_round_id])
	
		@round.projects.each_with_index do |p,i|
			@prev_contribution = Contribution.where(:user_id => current_user.id, :round_id => @round.id, :project_id => p.id).first
			@prev_contribution.destroy unless @prev_contribution.nil?
			if params["amount_#{i}".to_sym] == ""
				@amount = 0
			else
				@amount = params["amount_#{i}".to_sym]
			end
			
			if !Contribution.create(:amount => @amount, :project_id => params["project_id_#{i}".to_sym], :time_contributed => Time.now, :user_id => current_user.id, :round_id => params[:current_round_id])
				flash[:error] = "There was an error createing one or more of the contributions."
			end
		end
		
		@preferences = Preferences.where(:user_id => current_user.id, :round_id => @round.id).first
		@preferences.ready_save_and_check_summary
		
		redirect_to summary_waiting_path(@round)
	end
end