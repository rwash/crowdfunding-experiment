class RoundsController < InheritedResources::Base
        

	def waiting_for_round
	  @experiment = current_experiment
		@current_round = Round.find(params[:id])
    @user = current_user
    
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
		@number_of_project_options = ALLOWED_NUMBER_OF_PROJECTS_PER_CREATOR + 1
		
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

    if @current_round.part_b_finished || @user.user_type == "Creator" 
      redirect_to summary_waiting_path(@current_round)    
    elsif @user.user_type == "Donor"
      @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round).first
      @current_group = @preference.group
  		@projects = Project.where(:group_id => @current_group )
      redirect_to summary_waiting_path(@current_round) if @preference.finished_round
    end
	end
	
	
	def waiting_for_summary
    @user = current_user
		@current_round = Round.find(params[:id]) 
		@experiment = current_experiment
		
    if @current_round.check_if_round_complete
      # Calculate funding details for each project 
      Group.where(:round_id => @current_round).each do |group|
        group.projects.each do |project|
          project.calculate_funding_details 
        end
      end

      # Calculate Total_Return for each Creator
      CreatorPreference.where(:round_id => @current_round).each do |preference|
        preference.calculate_total_return
      end
    
      # Calculate Total_Return for each Donor
      DonorPreference.where(:round_id => @current_round).each do |preference|
        preference.calculate_total_return  
      end 
    
      @current_round.summary_complete = true
      @current_round.save! 

      if @user.user_type == "Creator"
        redirect_to creator_round_summary_path(@current_round)   
      elsif @user.user_type == "Donor"
        redirect_to donor_round_summary_path(@current_round)  
      end
    end
	end
	
	
	def creator_summary       # <TODO CL> Revise and Refactor. Move into model. Duplicated.
		@user = current_user
		@current_experiment = current_experiment
		@current_round = Round.find(params[:id])
	  @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
    @current_group = @preference.group
		@projects = @current_group.projects   
		@next_round_number = @current_round.number + 1
		@next_round = @current_experiment.rounds.where(:number => @next_round_number).first
	end         
	
	
	def donor_summary      # <TODO CL> Revise and Refactor. Move into model. Duplicated.     
	  @user = current_user
		@current_experiment = current_experiment
		@current_round = Round.find(params[:id]) 
    @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round.id).first 
    @current_group = @preference.group
		@projects = @current_group.projects 
		@next_round_number = @current_round.number + 1
		@next_round = @current_experiment.rounds.where(:number => @next_round_number).first
	end
	
end
