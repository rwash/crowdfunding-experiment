class Project < ActiveRecord::Base
	belongs_to :round
	has_many :contributions
	
	after_create :generate_name
	
	def initialize(attributes = nil, options = {})
		super
		self.goal_amount = 100
		self.start_amount = rand(0..99)
		self.funded_amount = 0
	end
	
	def generate_name
		# self.name = "Project " + self.id.to_s
		self.name = PROJECT_NAMES[rand(PROJECT_NAMES.length)]
		self.save!
	end
	
	def funded?
		self.goal_amount <= self.funded_amount
	end
end
