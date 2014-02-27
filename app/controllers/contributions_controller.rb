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
    
    if @preference.credits_not_donated.blank?
      @user_donate_amount = AMOUNT_DONOR_CAN_DONATE_PER_ROUND
    else
      @user_donate_amount = @preference.credits_not_donated
    end
             
    if @total_amount_contributed > @user_donate_amount
      redirect_to round_show_part_b_path(@current_round), :alert => "Total amount contributed cannot exceed: #{@user_donate_amount} credits!" and return
    else
      @current_group.projects.each_with_index do |project, i|
        break if @project_id == 0
        @project_id = params["project_id_#{i}".to_sym].to_i
        @project = Project.find(@project_id)
        @amount_contributed = params["amount_#{i}".to_sym].to_i      
        
        if @amount_contributed > 0
          unless @project.create_contribution(@user, @amount_contributed)
            @total_amount_contributed = @total_amount_contributed - @amount_contributed
            #The only reason for a false return would be if they have donated more than 30 to a project
            redirect_to round_show_part_b_path(@current_round), :alert => "Cannot contribute more than #{MAX_PROJECT_DONATION} credits to a project" and return
          end          
        elsif @amount_contributed < 0
          redirect_to round_show_part_b_path(@current_round), :alert => "Cannot contribute negative amounts!" and return            
        end     
      end
      
      @preference.credits_not_donated = (@user_donate_amount - @total_amount_contributed) 
      @preference.save!  

      redirect_to round_show_part_b_path(@current_round), :notice => "Contributions submitted!"  
    end
  end
	
end                