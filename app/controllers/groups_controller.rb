class GroupsController < InheritedResources::Base

	def show_part_a          # <TODO CL> Revise.
		@current_round = Round.find(params[:id])
		@user = current_user
		@preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
		check_round(@current_round, @user)     # <TODO CL> Implement or Depricated?
		@number_of_project_options = ALLOWED_NUMBER_OF_PROJECTS_PER_CREATOR + 1
    # @group = @preference.group
    @group = Group.new 
    # 3.times { @group.projects.build(:name => "TEST") }   
	end

end
                                                                   