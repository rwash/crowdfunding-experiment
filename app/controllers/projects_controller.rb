class ProjectsController < InheritedResources::Base
                          

  def create_projects                  # <TODO CL> Refactor and Move into Model.
    @user = current_user  
    @experiment = @user.experiment     
		@current_round = Round.find(params[:id])    
		@number_of_projects = params[:number_of_projects].to_i
    @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
    @current_group = @preference.group
    @build_group = Group.new(params[:group])  
    
    if @preference.finished_round == false    
      @build_group.projects.each do |project|
        @new_project = Project.new
        @new_project.update_attributes(:user_id => @user.id, :group_id => @current_group.id, :name => project.name, :value => project.value, :popularity => project.popularity)     
        @current_group.projects << @new_project  
        @number_of_projects += 1          
      end  
      @current_group.save!
            
      @preference.credits_not_spent = (AMOUNT_CREATOR_CAN_SPEND_PER_ROUND - (@number_of_projects * COST_TO_CREATE_PROJECT))
      @preference.set_finished_round
      @current_round.check_if_part_a_finished
      redirect_to summary_waiting_path(@current_round)
    else
      flash[:alert] = "You have finished your turn for this round!"
      redirect_to summary_waiting_path(@current_round)     
    end      
  end       

end