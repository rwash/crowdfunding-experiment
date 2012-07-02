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
		@preferences = Preferences.where(:user_id => current_user.id, :round_id => @round.id).first
		
		if params[:expired].nil?
		
			#checks to make sure they havnt alread submitted a contributon
			@prev_contribution = Contribution.where(:user_id => current_user.id, :round_id => @round.id).first
			if !@prev_contribution.nil?
				flash[:error] = "You cannot edit your contribution after you have submitted."
				return redirect_to summary_waiting_path(@round)
			end
	
			@total = 0
			@round.projects.size.times do |i|
				@total = @total + params["amount_#{i}".to_sym].to_i
			end
			
			if(@total > AMOUNT_USER_CAN_DONATE_PER_ROUND)
				flash[:error] = "You can not donate more then the allotted amount."
				return redirect_to @round
			end
			
			#give users back the money they didnt spend/donate
			@preferences.round_payout = AMOUNT_USER_CAN_DONATE_PER_ROUND - @total
			@preferences.save!
							
		else
			@preferences.timer_expired = true
			@preferences.save!
		end
		
			@round.projects.each_with_index do |p,i|			
				if params["amount_#{i}".to_sym] == ""
					@amount = 0
				else
					@amount = params["amount_#{i}".to_sym]
				end
				
				if !Contribution.create(:amount => @amount, :project_id => params["project_id_#{i}".to_sym], :time_contributed => Time.now, :user_id => current_user.id, :round_id => @round.id)
					flash[:error] = "There was an error createing one or more of the contributions."
					return redirect_to root_path
				end
				
			end
		
		
		@preferences.ready_save_and_check_summary
		
		redirect_to summary_waiting_path(@round)
	end
	
end