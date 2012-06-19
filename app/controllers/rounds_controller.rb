class RoundsController < InheritedResources::Base
	def summary
		@current_round = Round.find(params[:id])
		@user = current_user
		@preferences = Preferences.where(:user_id => @user.id, :round_id => @current_round.id)
		@next_round = Round.where(:id => @current_round.id + 1).first
	end
end
