class ContributionsController < InheritedResources::Base
            

  def submit      # <TODO CL> Refactor and move into model.
    @current_round = Round.find(params[:current_round_id])
    @user = current_user
    @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round).first    
    @current_group = @preference.group 
    
    @total_amount_contributed = 0
    @current_group.projects.each_with_index do |project, i|
      @amount_contributed = params["amount_#{i}".to_sym].to_i
      @total_amount_contributed += @amount_contributed
    end 
    
    @preference.credits_not_donated = (AMOUNT_DONOR_CAN_DONATE_PER_ROUND - @total_amount_contributed) 
    @preference.save! 
             
    if @preference.finished_round
      redirect_to summary_waiting_path(@current_round), :alert => "You have already finished your turn for this round!" and return
    elsif @total_amount_contributed > AMOUNT_DONOR_CAN_DONATE_PER_ROUND
      redirect_to round_show_part_b_path(@current_round), :alert => "Total amount contributed cannot exceed: #{AMOUNT_DONOR_CAN_DONATE_PER_ROUND} credits!" and return
    else
      @current_group.projects.each_with_index do |project, i|
        @project_id = params["project_id_#{i}".to_sym].to_i
        @project = Project.find(@project_id)
        @amount_contributed = params["amount_#{i}".to_sym].to_i      
        
        if @amount_contributed > 0
          @project.create_contribution(@user, @amount_contributed)  
        elsif @amount_contributed < 0
          redirect_to round_show_part_b_path(@current_round), :alert => "Cannot contribute negative amounts!" and return            
        end     
      end
      @preference.set_finished_round 
      @preference.save!  
      redirect_to summary_waiting_path(@current_round), :notice => "Contributions submitted!"  
    end
  end
	
end                