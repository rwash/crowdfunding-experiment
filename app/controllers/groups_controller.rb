class GroupsController < InheritedResources::Base
                                                                                  

	def show_part_a1
		@current_round = Round.find(params[:id])
    if current_admin_user.present?
      @user = @current_round.experiment.users.where("user_type = ?", "Creator").first
    else
      @user = current_user
    end        
		
		@preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first 
    @group = Group.new  
		
    set_user_status(@user, "In Part A: Create Projects - Round ##{@current_round.number}")  
	end   
	
  
  def show_part_a2
		@current_round = Round.find(params[:id])                  
    if current_admin_user.present?
      @user = @current_round.experiment.users.where("user_type = ?", "Creator").first
    else
      @user = current_user
    end            
    @preferences = CreatorPreference.where(:user_id => @user, :round_id => @current_round)
  end
	
end