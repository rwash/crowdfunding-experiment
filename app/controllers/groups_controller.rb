class GroupsController < InheritedResources::Base
                                                                                  

	def show_part_a1          # <TODO CL> Revise.
		@current_round = Round.find(params[:id])
		@user = current_user
		@preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first 
		
    set_user_status(@user, "In Part A: Create Projects - Round ##{@current_round.number}")  
		
		check_round(@current_round, @user)     # <TODO CL> Implement or Depricated?
    @group = Group.new               
	end   
	
  
  def show_part_a2
    @user = current_user   
		@current_round = Round.find(params[:id])                  
    @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
    @current_group = @preference.group
    @projects = []
    @current_group.projects.where(:user_id => @user.id).each do |project|
		  @projects << project
		end
  end
	
end