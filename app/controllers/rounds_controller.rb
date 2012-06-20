class RoundsController < InheritedResources::Base
	def summary
		@current_round = Round.find(params[:id])
		@user = current_user
		@preferences = Preferences.where(:user_id => @user.id, :round_id => @current_round.id).first
		@next_round = Round.where(:id => @current_round.id + 1).first
		@projects = Project.where(:round_id => @current_round.id)
		
		@current_round.round_over
	end
	
	def show
		@round =  Round.find(params[:id])
		@user = current_user
		@preferences = Preferences.where(:user_id => @user.id, :round_id => @round.id).first
	end
end
