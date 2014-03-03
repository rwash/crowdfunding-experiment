class ProjectsController < InheritedResources::Base
                          

  def create_projects                  # <TODO CL> Refactor and Move into Model.
    @current_round = Round.find(params[:id])    
    if current_admin_user.present?
      @user = @current_round.experiment.users.where("user_type = ?", "Creator").first
    else
      @user = current_user
    end        
    @experiment = @user.experiment         
    @number_of_projects = 3

    @preferences = CreatorPreference.where(:user_id => @user, :round_id => @current_round)
    @preferences.each do |preference|
      current_group = preference.group

      if preference.finished_round == false    
        Group.transaction do 
          name_projects = ["Red", "Yellow", "Blue"]
          3.times do |itr|
            @new_project = Project.new
            @new_project.update_attributes(:user_id => @user.id, 
              :group_id => current_group.id, :name => name_projects[itr], 
              :value => "Low", :popularity => ["Popular", "Niche"].sample
            )     
            current_group.projects << @new_project  
            @number_of_projects += 1          
          end  
          
          if current_group.save
            preference.credits_not_spent = (AMOUNT_CREATOR_CAN_SPEND_PER_ROUND - (@number_of_projects * COST_TO_CREATE_PROJECT))
            preference.set_finished_round
            @current_round.check_if_part_a_finished
            
          else
            raise ActiveRecord::Rollback
          end
        end
      end        
    end
    redirect_to round_show_part_a2_path(@current_round)
  end                             
end