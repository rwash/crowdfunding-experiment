class UsersController < InheritedResources::Base
	def instructions
		current_user.times_viewed_instructions = current_user.times_viewed_instructions + 1
		current_user.save!
	end
end
