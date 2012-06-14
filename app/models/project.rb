class Project < ActiveRecord::Base

	belongs_to :round
	
	def initialize(attributes = nil, options = {})
		super
		self.goal_ammount = 100
		self.current_amount = 0
	end
end
