class RoundsController < InheritedResources::Base

	def waiting_for_round
	  @experiment = current_experiment
		@current_round = Round.find(params[:id])
    @user = current_user
    # unless @user.group_id == @current_round.group_id
    #   @user.group_id = @current_round.group_id
    #   @user.save!
    # end    
    
		if @user.user_type == "Creator"
		  @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
		elsif @user.user_type == "Donor"
      @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round.id).first
		end
		
    @preference.set_ready_to_start unless @preference.is_ready
    @current_round.check_if_round_ready_to_start
    redirect_to round_show_part_a_path(@current_round) if @current_round.part_a_started
	end
	

	def show_part_a
		@current_round = Round.find(params[:id])
		@user = current_user
		check_round(@current_round, @user)
		
		if @current_round.part_b_started
      redirect_to waiting_for_part_b_path(@current_round)		  
		elsif @user.user_type == "Creator"
		  @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
      redirect_to summary_waiting_path(@current_round) if @preference.finished_round
    elsif @user.user_type == "Donor"
      redirect_to waiting_for_part_b_path(@current_round)
    end
	end
	
	
	def show_part_a_2
		@current_round = Round.find(params[:id])
		@user = current_user
	  @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
    @number_of_projects = params[:numberOfProjects].to_i
    if @number_of_projects == 0
      @preference.set_finished_round
      @current_round.check_if_part_a_finished
      redirect_to summary_waiting_path(@current_round)
    end
	end
	
	
	def waiting_for_part_b
		@current_round = Round.find(params[:id])
	  if @current_round.part_b_started
	    redirect_to round_show_part_b_path(@current_round)
	  end
	end
	
	
	def show_part_b
	  @current_round = Round.find(params[:id])
		@user = current_user

    if @current_round.part_b_finished
      redirect_to summary_waiting_path(@current_round)    
    elsif @user.user_type == "Donor"
      @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round.id).first
  		@projects = Project.where(:round_id => @current_round.id)
      redirect_to summary_waiting_path(@current_round) if @preference.finished_round
  	else @user.user_type == "Creator"   # <TODO CL> Can remove, no "Creator" Users should be able to get to this point!
  	  redirect_to summary_waiting_path(@current_round)
    end
	end
	
	
	def waiting_for_summary
		@current_round = Round.find(params[:id])
    @current_round.check_if_round_complete
    if @current_round.part_b_finished
      redirect_to round_summary_path(@current_round)
    end
	end
	
	
	def summary
		@current_round = Round.find(params[:id])
		@user = current_user
		@current_experiment = current_experiment
		@projects = @current_round.projects
		
		@contributions = []
		@projects.each do |project|
		  project.contributions.each do |contribution|
		    @contributions << contribution
		  end
		end
		
		@next_round_number = @current_round.number + 1
		@next_round = @current_experiment.rounds.where(:number => @next_round_number).first
	end
	
end
