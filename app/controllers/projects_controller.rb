class ProjectsController < InheritedResources::Base
                          

  def create_projects                  # <TODO CL> Refactor and Move into Model.
    @user = current_user       
		@current_round = Round.find(params[:id])    
		@number_of_projects = params[:number_of_projects].to_i
    @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
    @current_group = @preference.group
 
    if @preference.finished_round == false    
      @number_of_projects.times do |i|
        @current_group.projects << Project.new(:user => @user, :group => @current_group, :value => params["project#{i}Value".to_sym], :popularity => params["project#{i}Popularity".to_sym])     
      end                    
      
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