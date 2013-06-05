class ProjectsController < InheritedResources::Base

  def create_projects
		@current_round = Round.find(params[:id])
    @user = current_user
    @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
    
    if @preference.finished_round == false
      if params[:project1Value]
        @current_round.projects << Project.new(:round => @current_round, :value => params[:project1Value])
      end
      if params[:project2Value]
        @current_round.projects << Project.new(:round => @current_round, :value => params[:project2Value])
      end

      @preference.set_finished_round
      @current_round.check_if_part_a_finished
      redirect_to summary_waiting_path(@current_round)
    else
      flash[:alert] = "You have finished your turn for this round!"
      redirect_to summary_waiting_path(@current_round)
    end
  end

end