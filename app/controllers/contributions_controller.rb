class ContributionsController < InheritedResources::Base
            

  def submit      # <TODO CL> Refactor and move into model.
    @current_round = Round.find(params[:current_round_id])
    @user = current_user
    @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round).first    
    @current_group = @preference.group 
    @time_left = @current_round.remaining_seconds
    
    @total_amount_contributed = 0
    @current_group.projects.each_with_index do |project, i|
      @amount_contributed = params["amount_#{i}".to_sym].to_i
      @total_amount_contributed += @amount_contributed
    end 
    
    if @preference.credits_not_donated.blank?
      @user_donate_amount = AMOUNT_DONOR_CAN_DONATE_PER_ROUND
    else
      @user_donate_amount = @preference.credits_not_donated
    end
             
    #if @total_amount_contributed > @user_donate_amount
    #  redirect_to round_show_part_b_path(@current_round), :alert => "Total amount contributed cannot exceed: #{@user_donate_amount} credits!" and return
    #else
    #  @current_group.projects.each_with_index do |project, i|
    #    break if @project_id == 0
    #    @project_id = params["project_id_#{i}".to_sym].to_i
    #    @project = Project.find(@project_id)
    #    @amount_contributed = params["amount_#{i}".to_sym].to_i      
    #    
    #    if @amount_contributed > 0
    #      unless @project.create_contribution(@user, @amount_contributed)
    #        @total_amount_contributed = @total_amount_contributed - @amount_contributed
    #        #The only reason for a false return would be if they have donated more than 30 to a project
    #        redirect_to round_show_part_b_path(@current_round), :alert => "Cannot contribute more than #{MAX_PROJECT_DONATION} credits to a project" and return
    #      end          
    #    elsif @amount_contributed < 0
    #      redirect_to round_show_part_b_path(@current_round), :alert => "Cannot contribute negative amounts!" and return            
    #    end     
    #  end
    #  
    #  @preference.credits_not_donated = (@user_donate_amount - @total_amount_contributed) 
    #  @preference.save!
    
    
    # Replacing above with new way of validating-
    # First check that all fields are valid
    # If valid, enter all of them in the db and update the donor_preference
    # If any are not valid, return an error and do not submit any of them
    
    @valid = true
    @alert = "There was a problem with at least one of your contributions. Your contributions were not submitted"
    
    @current_group.projects.each_with_index do |project, i|
      break if @project_id == 0
      @project_id = params["project_id_#{i}".to_sym].to_i
      @project = Project.find(@project_id)
      @amount_already_contributed_to_project_by_user = @project.get_contribution(@user)
      @amount_already_contributed_to_project_by_user = 0 unless @amount_already_contributed_to_project_by_user
      @amount_contributed = params["amount_#{i}".to_sym].to_i

      if params["amount_#{i}"].nil?
	@valid = false
	@alert = "Please submit only integers"
      end
      if @amount_contributed < 0
	@valid = false
	@alert = "You cannot contributed negative numbers"
      elsif @amount_contributed > (MAX_PROJECT_DONATION - @amount_already_contributed_to_project_by_user)
	@valid = false
	@alert = "You cannot contribute more than #{MAX_PROJECT_DONATION - @amount_already_contributed_to_project_by_user} credits to this project"
	
      end
      
      
    end
    
    if @valid
      @current_group.projects.each_with_index do |projects, i|
	@project_id = params["project_id_#{i}".to_sym].to_i
	@project = Project.find(@project_id)
	@amount_contributed = params["amount_#{i}".to_sym].to_i
	
	if @amount_contributed > 0
	  @project.create_contribution(@user, @amount_contributed)
	end
      end
      @preference.credits_not_donated = (@user_donate_amount - @total_amount_contributed)
      @preference.save!
    
    else
      redirect_to round_show_part_b_path(@current_round), :alert => @alert and return
    end
      
    

    if @time_left < FINAL_DONATION_PERIOD_SECONDS
      redirect_to summary_waiting_path(@current_round) and return
    else
      redirect_to round_show_part_b_path(@current_round), :notice => "Contributions submitted!" and return
    end
  end
	
end                