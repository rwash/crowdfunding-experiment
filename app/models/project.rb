class Project < ActiveRecord::Base
	belongs_to :round
	has_many :contributions, :dependent => :destroy
	
	after_create :generate_name
	
	def initialize(attributes = nil, options = {})
		super
		self.goal_amount = 400
		self.funded_amount = 0
	end
	
	def generate_name
		# self.name = "Project " + self.id.to_s
		self.name = $project_names[0]
		$project_names.delete($project_names[0])
		
		# if we run out of names refill the array again
		if $project_names == []
			reseed_names
		end
		
		self.save!
	end
	
	def funded?
		self.goal_amount <= self.funded_amount
	end
	
	def reseed_names
			require 'csv'
			$project_names = []
			CSV.foreach("colors4.csv", :headers => false) do |row|
			  $project_names << row[0]
			end
			
			$project_names.each do |n|
				n.gsub!(";",'')
			end
	end
end
