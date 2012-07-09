class PreferencesController < InheritedResources::Base
	def flag
		@preferences = Preferences.find(params[:id])
	end
	
	def unflag
		@preferences = Preferences.find(params[:id])
		
		@preferences.flag_note = ''
		@preferences.flag = false
		@preferences.save!
		
		redirect_to :back
	end
	
	def flag_submit
		@preferences = Preferences.find(params[:id])

		@preferences.flag_note = params[:note]
		@preferences.flag = true
		@preferences.save!
		
		render :text => '<script type="text/javascript"> parent.$.fn.colorbox.close() </script>'
	end
end
