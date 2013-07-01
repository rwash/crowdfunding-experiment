class Project < ActiveRecord::Base
	has_many :contributions, :dependent => :destroy
	belongs_to :group                                               
	belongs_to :user  
	
		
  # after_initialize :generate_name     # <TODO CL>
	after_create :initalize_project
	after_create :assign_special_users 
  
  
  def create_contribution(user, amount_contributed)
    @user = user                                                                                   
    @current_group = group
    @amount_contributed = amount_contributed
    self.contributions << Contribution.new(:user_id => @user.id, :project_id => self, :amount => @amount_contributed)
    self.save!
  end


	def initalize_project
		if self.value == "High" && self.popularity == "Popular"
		  self.goal_amount = HIGH_VALUE_PROJECT_GOAL
		  self.standard_return_amount = STANDARD_RETURN_AMOUNT_HIGH_VALUE_POPULAR
		  self.special_return_amount = 0
		elsif self.value == "High" && self.popularity == "Niche"
		  self.goal_amount = HIGH_VALUE_PROJECT_GOAL
		  self.standard_return_amount = STANDARD_RETURN_AMOUNT_HIGH_VALUE_NICHE
		  self.special_return_amount = SPECIAL_RETURN_AMOUNT_HIGH_VALUE_NICHE 	  
		elsif self.value == "Low" && self.popularity == "Popular"  
		  self.goal_amount = LOW_VALUE_PROJECT_GOAL
		  self.standard_return_amount = STANDARD_RETURN_AMOUNT_LOW_VALUE_POPULAR
		  self.special_return_amount = 0 	  
	  elsif self.value == "Low" && self.popularity == "Niche"   
      self.goal_amount = LOW_VALUE_PROJECT_GOAL
		  self.standard_return_amount = STANDARD_RETURN_AMOUNT_LOW_VALUE_NICHE
		  self.special_return_amount = SPECIAL_RETURN_AMOUNT_LOW_VALUE_NICHE     
		end     
		self.save!
	end 
	
	
	def assign_special_users    # <TODO CL> Revise and refactor.
    @group = self.group 
    @random_special_donors = (0..(NUMBER_OF_DONORS_PER_GROUP-1)).to_a.sort{ rand() - 0.5 }[0..(NUMBER_SPECIAL_DONORS_PER_GROUP-1)]                  
    @first_special = true
    DonorPreference.where(:group_id => @group).each_with_index do |preference, i|
      if @random_special_donors.include?(i) && @first_special
        self.special_user_1 = preference.user_id     # <TODO CL> This saves the id to the project as a value, not the object as a foreign key.
        @first_special = false                                     
      elsif @random_special_donors.include?(i)
        self.special_user_2 = preference.user_id      
      end
    end
	  self.save!
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
	
	
	def calculate_funding_details
    @experiment = self.group.round.experiment
    @total_amount_contributed = 0
	  self.contributions.each do |contribution|
	    @total_amount_contributed += contribution.amount
	  end                 

	  self.total_contributions = @total_amount_contributed
	  self.number_donors = self.contributions.count
    if @total_amount_contributed >= self.goal_amount
      self.funded = true
      if self.value == "High"
        self.creator_earnings = CREATOR_EARNINGS_HIGH_VALUE_PROJECT  
      elsif self.value == "Low"
        self.creator_earnings = CREATOR_EARNINGS_LOW_VALUE_PROJECT        
      end
    else
      self.funded = false       
      if @experiment.return_credits
        self.creator_earnings = COST_TO_CREATE_PROJECT 
      else
        self.creator_earnings = 0
      end
    end 
	  self.save!
	end
	
	
	def get_contribution(user)
	  @user = user
	  self.contributions.each do |contribution|
	    if contribution.user_id == @user.id
	      return contribution 
	    end
	  end
	  return false
	end

end
