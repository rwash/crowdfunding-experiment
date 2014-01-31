class RoundsController < InheritedResources::Base
        

	def waiting_for_round
	  @experiment = current_experiment
		@current_round = Round.find(params[:id])
    @user = current_user       
    @experiment.start_experiment
		
    if @current_round.round_complete
		  redirect_to summary_waiting_path(@current_round)
    elsif @user.user_type == "Creator"
      @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first       
      @preference.set_ready_to_start unless @preference.is_ready
      if @preference.finished_round
        redirect_to summary_waiting_path(@current_round) 
      else
        @current_round.start_round_part_a 
        redirect_to round_show_part_a1_path(@current_round)
      end
    elsif @user.user_type == "Donor" 
      @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round.id).first 
      @preference.set_ready_to_start unless @preference.is_ready 
      @current_round.check_if_round_part_b_ready_to_start   

      set_user_status(@user, "Waiting for Round ##{@current_round.number} to Start")
      
      if @current_round.part_a_started
        redirect_to waiting_for_part_b_path(@current_round)
      elsif @preference.finished_round 
        redirect_to summary_waiting_path(@current_round)              
      end
    end
  end 

	
	def waiting_for_part_b
		@current_round = Round.find(params[:id])  
		@user = current_user
		
    set_user_status(@user, "Waiting for Round ##{@current_round.number} - Part B")   
		
	  if @current_round.part_b_started
	    redirect_to round_show_part_b_path(@current_round)
	  end
	end
	
	
	def show_part_b
	  @current_round = Round.find(params[:id])
		@user = current_user    
		
    set_user_status(@user, "In Part B: Submit Contributions - Round ##{@current_round.number}")   

    if @current_round.part_b_finished || @user.user_type == "Creator" 
      redirect_to summary_waiting_path(@current_round)    
    elsif @user.user_type == "Donor"
      @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round).first
      @current_group = @preference.group
      @preference.generate_project_display_order(@current_group)  
      @projects = @preference.get_project_list
      @projects.each do |project|
        project.calculate_funding_details 
      end

      if @preference.credits_not_donated.blank?
        @user_donate_amount = AMOUNT_DONOR_CAN_DONATE_PER_ROUND
      else
        @user_donate_amount = @preference.credits_not_donated
      end

      if @current_round.remaining_seconds == 0
        @preference.set_finished_round
      end
      redirect_to summary_waiting_path(@current_round) if @preference.finished_round
    end
	end
	
	
	def waiting_for_summary
    @user = current_user
		@current_round = Round.find(params[:id]) 
		@experiment = current_experiment    
		@group = Group.where(:round_id => @current_round)

    set_user_status(@user, "Waiting for Round ##{@current_round.number} Summary")  
		
    if @current_round.remaining_seconds == 0
      @current_round.set_finished_round
    end    
    if @current_round.check_if_round_complete
      Group.where(:round_id => @current_round).each do |group|
        group.projects.each do |project|
          project.calculate_funding_details 
        end
      end

      CreatorPreference.where(:round_id => @current_round).each do |preference|
        preference.calculate_total_return
      end

      DonorPreference.where(:round_id => @current_round).each do |preference|
        preference.calculate_total_return  
      end 
    
      @current_round.summary_complete = true
      @current_round.save!     
                                    
      @next_round_number = @current_round.number + 1
      @experiment.set_current_round(@next_round_number)      # <TODO CL> Check this sets the current round to the experiment properly.

      if @user.user_type == "Creator"
        redirect_to creator_round_summary_path(@current_round)   
      elsif @user.user_type == "Donor"
        redirect_to donor_round_summary_path(@current_round)  
      end
    else
      if @user.user_type == "Creator"
        @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
        @current_group = @preference.group
        @projects = @current_group.projects   
        @projects.each do |project|
          project.calculate_funding_details 
        end
      elsif @user.user_type == "Donor"
        @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round.id).first 
        @current_group = @preference.group
        @projects = @preference.get_project_list
        @projects.each do |project|
          project.calculate_funding_details 
        end        
      end      
    end
	end
	
	
	def creator_summary
		@user = current_user
		@experiment = current_experiment
		@current_round = Round.find(params[:id])
	  @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
    @current_group = @preference.group
		@projects = @current_group.projects   
		@next_round_number = @current_round.number + 1
		@next_round = @experiment.rounds.where(:number => @next_round_number).first  
		
    set_user_status(@user, "Viewing Round ##{@current_round.number} Summary") 		
	end         
	
	
	def donor_summary    
	  @user = current_user
		@experiment = current_experiment
		@current_round = Round.find(params[:id]) 
    @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round.id).first 
    @current_group = @preference.group 
    @projects = @preference.get_project_list 		     
		@next_round_number = @current_round.number + 1
		@next_round = @experiment.rounds.where(:number => @next_round_number).first   
		
    set_user_status(@user, "Viewing Round ##{@current_round.number} Summary") 	 		
	end      
	
	
	def round_history
    @round = Round.find(params[:id])
    @experiment = @round.experiment
    @round_preferences = []
    @experiment.users.each do |user|
  		if user.user_type == "Creator"
  		  @preference = CreatorPreference.where(:user_id => user, :round_id => @round).first
  		elsif user.user_type == "Donor"
        @preference = DonorPreference.where(:user_id => user, :round_id => @round.id).first
  		end
      @round_preferences << @preference
    end
	end

  def countdown
    @round = Round.find(params[:id])
    render json: {count: @round.remaining_seconds}.to_json
  end

  def update_donation_results
    @current_round = Round.find(params[:id])
    @user = current_user        

    if @user.user_type == "Donor"
      @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round).first
      @current_group = @preference.group
      @preference.generate_project_display_order(@current_group)  
      @projects = @preference.get_project_list
      @projects.each do |project|
        project.calculate_funding_details 
      end
    end    

    render layout: false
  end
	
end
