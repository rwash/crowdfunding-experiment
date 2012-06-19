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
	
		4.times do |i|
			if !Contribution.create(:ammount => params["amount_#{i}".to_sym], :project_id => params["project_id_#{i}".to_sym], :time_contributed => Time.now, :user_id => current_user.id, :round_id => params[:current_round_id])
				flash[:error] = "There was an error createing one or more of the contributions."
			end
		end
		
		redirect_to round_summary_path(@round)
	end
end