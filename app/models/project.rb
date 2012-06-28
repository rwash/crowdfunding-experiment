class Project < ActiveRecord::Base
	belongs_to :round
	has_many :contributions
	
	after_create :generate_name
	
	def initialize(attributes = nil, options = {})
		super
		self.goal_amount = 400
		self.funded_amount = 0
	end
	
	def generate_name
		# self.name = "Project " + self.id.to_s
		self.name = PROJECT_NAMES[0]
		PROJECT_NAMES.delete(PROJECT_NAMES[0])
		
		# if we run out of names refill the array again
		if PROJECT_NAMES == []
			require 'csv'
			CSV.foreach("colors2.csv", :headers => false) do |row|
			  PROJECT_NAMES << row[0]
			end
			
			PROJECT_NAMES.each do |n|
				n.gsub!(";",'')
			end
		end
		
		self.save!
	end
	
	def funded?
		self.goal_amount <= self.funded_amount
	end
end
