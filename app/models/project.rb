class Project < ActiveRecord::Base
	has_many :contributions, :dependent => :destroy
	belongs_to :round
		
	after_create :generate_name
	after_create :initialize
	

  def create_contribution(user, group, round, amount_contributed)
    @user = user
    @current_round = round                                                                                             
    @group = group
    @amount_contributed = amount_contributed
    self.contributions << Contribution.new(:user_id => @user.id, :group_id => @group.id, :amount => @amount_contributed)
    self.save!
  end


	def initialize    # <TODO CL> Use Environmental Variables and add in Other Project Types
		self.goal_amount = 400
		self.funded_amount = 0
	end
	
	
	def generate_name       # <TODO CL> Revise, lots of duplication with the Reseeding Names.
		self.name = $project_names[0]
		$project_names.delete($project_names[0])
		
		# if we run out of names refill the array again
		if $project_names == []
			reseed_names
		end
		self.save!
	end      
	
	
	def reseed_names        # <TODO CL> Revise.
		require 'csv'
		$project_names = []
		CSV.foreach("colors4.csv", :headers => false) do |row|
		  $project_names << row[0]
		end

		$project_names.each do |n|
			n.gsub!(";",'')
		end 
	end
	
	
	def funded?       # <TODO CL> Depricated?
		self.goal_amount <= self.funded_amount
	end

end
