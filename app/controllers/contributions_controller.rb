class ContributionsController < InheritedResources::Base
  
  # def create
  #   @contribution = Contribution.create(params[:contribution])
  #     if @contribution.save
  #     flash[:notice] = "Contribution Successfull"
  #   else
  #     flash[:error] = "FAILED to Contribute"
  #   end
  #   redirect_to new_contribution_path
  # end
	

  def submit
    @current_round = Round.find(params[:current_round_id])
    @user = current_user
    @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round.id).first
    
    redirect_to summary_waiting_path(@current_round) if @preference.finished_round

    # @total_amount_contributed = 0
    # @current_round.projects.each_with_index do |project, i|
    #   @amount_contributed = params["amount_#{i}".to_sym].to_i
    #   @total_amount_contributed += @amount_contributed
    # end
    # if @total_amount_contributed > AMOUNT_USER_CAN_DONATE_PER_ROUND
    #   redirect_to round_show_part_b_path(@current_round), alert: "You cannot contribute that much!"
    # end

    @current_round.projects.each_with_index do |project, i|
      @project_id = params["project_id_#{i}".to_sym].to_i
      @project = Project.find(@project_id)
      @amount_contributed = params["amount_#{i}".to_sym].to_i
      if @amount_contributed > 0
        @project.create_contribution(@user, @current_round, @amount_contributed)
      end
    end
    
    @preference.finish_round
    redirect_to summary_waiting_path(@current_round)
  end
	
end