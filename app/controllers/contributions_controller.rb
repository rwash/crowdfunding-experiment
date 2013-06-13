class ContributionsController < InheritedResources::Base

  def submit
    @current_round = Round.find(params[:current_round_id])
    @user = current_user
    @preference = DonorPreference.where(:user_id => @user, :round_id => @current_round).first    
    @group = @preference.group
    
    if @preference.finished_round
      redirect_to summary_waiting_path(@current_round)
    else         # <TODO CL> Add input validation here to limit contribution amount
      @current_round.projects.each_with_index do |project, i|
        @project_id = params["project_id_#{i}".to_sym].to_i
        @project = Project.find(@project_id)
        @amount_contributed = params["amount_#{i}".to_sym].to_i
        if @amount_contributed > 0
          @project.create_contribution(@user, @group, @current_round, @amount_contributed)
        end     
      end
      @preference.set_finished_round 
      @preference.save!  
      redirect_to summary_waiting_path(@current_round)
    end
  end
	
end