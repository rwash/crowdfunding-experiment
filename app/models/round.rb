class Round < ActiveRecord::Base         
	belongs_to :experiment          
	has_many :groups, :dependent => :destroy    
	has_many :creator_preferences, :through => :groups
	has_many :donor_preferences, :through => :groups
		
  after_create :generate_groups  
     

	def generate_groups       # <TODO CL> Revise, groups need to be randomly allocated between rounds.
		reseed_names
		self.groups << Group.create(:name => 'A')
		reseed_names
		self.groups << Group.create(:name => 'B')
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


  def check_if_part_a_finished
    CreatorPreference.where(:round_id => self.id).each do |preference|
      if preference.finished_round == false
        return false
      end
    end
    self.part_a_finished = true
    self.part_b_started = true
    self.save!
  end

	
	def check_if_round_ready_to_start
    self.creator_preferences.each do |creator_preference|
      return false if !creator_preference.is_ready
    end
    self.donor_preferences.each do |donor_preference|
      return false if !donor_preference.is_ready
    end
    self.part_a_started = true
    self.start_time = DateTime.now
    self.save!
  end
  
  
  def check_if_round_complete
    @experiment = self.experiment
    self.creator_preferences.each do |creator_preference|
      return false if !creator_preference.finished_round
    end
    self.donor_preferences.each do |donor_preference|
      return false if !donor_preference.finished_round
    end
    self.part_b_finished = true
    self.round_complete = true
    self.end_time = DateTime.now
    self.save! 

    if self.last_round?
      @experiment.experiment_over
    end
    return true
  end
  

  def last_round?
    return true if self.number == TOTAL_NUMBER_OF_ROUNDS
  end

	
	def round_started
		self.start_time = DateTime.now
		self.save!
	end
	
end
