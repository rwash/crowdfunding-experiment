class PreferencesController < InheritedResources::Base
	def flag
		@preferences = Preferences.find(params[:id])
		
		@preferences.flag = true
		@preferences.save!
		
		redirect_to :back
	end
end
