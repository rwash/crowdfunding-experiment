class RoundsController < InheritedResources::Base

	def summary
		@current_round = Round.find(params[:id])
		@user = current_user
		@preferences = Preferences.where(:user_id => @user.id, :round_id => @current_round.id).first
		@contributions = Contribution.where(:user_id => current_user.id, :round_id => @current_round.id)
		
		@not_donated = AMOUNT_USER_CAN_DONATE_PER_ROUND
		@contributions.each do |c|
			@not_donated = @not_donated - c.amount
		end
		
		@temp_rounds = current_experiment.rounds.where(:number => @current_round.number + 1)
		@next_round = nil
		unless @temp_rounds.first.nil?
			if @user.preferences.where(:round_id => @temp_rounds.first.id).first.nil?
				@next_round = @temp_rounds.last
			else
				@next_round = @temp_rounds.first
			end
		end
	
		@projects = Project.where(:round_id => @current_round.id)
	end
	
	
	def show_part_a
		@current_round = Round.find(params[:id])
		@user = current_user
		check_round(@current_round, @user)
		
    if @user.user_type == "Creator"
		  @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
      redirect_to summary_waiting_path(@current_round) if @preference.finished_round
    elsif @user.user_type == "Donor"
      redirect_to waiting_for_part_b_path(@current_round)
    end
	end
	
	
	def show_part_a_2
		@current_round = Round.find(params[:id])
		@user = current_user
    @number_of_projects = params[:numberOfProjects].to_i
    
    if @number_of_projects == 0
      redirect_to summary_waiting_path(@current_round)
    end
	end
	
	
	def waiting_for_part_b
		@current_round = Round.find(params[:id])    
	  if @current_round.part_b_started
	    redirect_to show_part_b_path(@current_round)
	  end
	end
	
	
	def show_part_b
	  @current_round = Round.find(params[:id])
		@user = current_user

    # CHECK THAT PART B HAS STARTED BEFORE DOING ANYTHING, IF THIS IS FIRST USER THEN SET THE ROUND PART B TO STARTED
    
    if @user.user_type == "Donor"
      @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round.id).first
      # Load Donor Interface        <TODO CL>
  		@projects = Project.where(:round_id => @current_round.id).order('id ASC')     # <TODO CL> What does this do?  Fix it!
  	else @user.user_type == "Creator"   # <TODO CL> Can remove, no "Creator" Users should be able to get to this point!
  	  redirect_to summary_waiting_path(@current_round)
    end
    
    # If User has finished the Round, redirect to Summary_Waiting
    @preference.check_if_finished_round
	end
	
	
	def waiting_for_summary
		@current_round = Round.find(params[:id])
		
    # if !@current_round.finished && current_user.id == @current_round.users.first.id
    #   @current_round.check_if_all_done
    # end
    # 
    # if current_experiment.rounds.where(:number => @current_round.number).first.finished && current_experiment.rounds.where(:number => @current_round.number).last.finished # TODO this line is really bad 
    # 
    #   if last_round?(@current_round)
    #     current_experiment.experiment_over if current_user == current_experiment.users.first # a cheap way to make sure it only happens once
    #   end
    #   
    #   redirect_to round_summary_path(@current_round)
    # end
	end
	
	
	def waiting_for_round
	  @experiment = current_experiment
		@current_round = Round.find(params[:id])
    @user = current_user

    unless @user.group_id == @current_round.group_id
      @user.group_id = @current_round.group_id
      @user.save!
    end
    
    # Find the correct preference record for the current User, for the current Round
		if @user.user_type == "Creator"
		  @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
		elsif @user.user_type == "Donor"
      @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round.id).first
		end
		
		# Set the User's preference for this round as READY and if all Users are ready, set the Round to READY
    @preference.set_ready_to_start unless @preference.is_ready
    @current_round.check_if_round_ready_to_start
    
    # Check if the current round has Started, and if so send the user into the round
    if @current_round.part_a_started
      @experiment.start_experiment unless @experiment.started
      @experiment.set_current_round(@current_round)
      redirect_to round_show_part_a_path(@current_round)
    end
	end
	
end
