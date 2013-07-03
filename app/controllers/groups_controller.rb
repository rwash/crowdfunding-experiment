class GroupsController < InheritedResources::Base

	def show_part_a          # <TODO CL> Revise.
		@current_round = Round.find(params[:id])
		@user = current_user
		@preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first 
		
    set_user_status(@user, "In Part A: Create Projects - Round ##{@current_round.number}")  
		
		check_round(@current_round, @user)     # <TODO CL> Implement or Depricated?
    @group = Group.new
    @project = Project.new(:name => generate_project_name)
    # ALLOWED_NUMBER_OF_PROJECTS_PER_CREATOR.times { @group.projects.build(:name => generate_project_name) }
	end   
	
end