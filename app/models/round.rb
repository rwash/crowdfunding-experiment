class Round < ActiveRecord::Base
	belongs_to :group
	has_one :experiment, :through => :group
	has_many :projects, :dependent => :destroy
	has_many :users, :through => :prefs
	has_many :contributions
	has_many :creator_preferences
	has_many :donor_preferences


  def check_if_part_a_finished    # <TODO CL>
    # Loop through Creator_Preferences for the Round
    CreatorPreference.where(:round_id => self.id).each do |preference|
      if preference.finished_round == false
        return false
      end
    end
    self.part_a_finished = true
    self.part_b_started = true
    self.save!
    
      # If a Creator has not finished the round
        # Return false
      # Elsif all Creators are finished
        # Set Round PartA to Complete
        # Set Round PartB to Started
        # Save
          

    # if self.part_a_finished && self.part_b_started != true
    #   self.part_b_started = true
    #   self.save!
    # end
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
  end
  

  def last_round?
    return true if self.number == NUMBER_OF_ROUNDS
  end

	
  # def check_if_all_done     # <TODO CL> Redudant? Remove.
  #   self.prefs.each do |p|
  #     if !p.finished_and_ready
  #       return false
  #     end
  #   end
  #   self.round_over
  # end

	
	def round_started
		self.start_time = DateTime.now
		self.save!
	end
	
	
	def round_over        # <TODO CL> Revise logic for end of round calculations.
		
    # self.projects.each do |p|         # <TODO CL> Redudant? Remove.
    #   p.funded_amount = p.start_amount
    #   p.contributions.each do |c|
    #     p.funded_amount += c.amount
    #   end
    #   p.save!
    # end
		
		@experiment = self.experiment
			
    # self.prefs.each do |p|
    #   p.round_payout = 0
    #   
    #   @total = 0
    # 
    #   @total = Contribution.where(:user_id => p.user_id, :project_id => self.projects[0].id).first.amount + Contribution.where(:user_id => p.user_id, :project_id => self.projects[1].id).first.amount + Contribution.where(:user_id => p.user_id, :project_id => self.projects[2].id).first.amount + Contribution.where(:user_id => p.user_id, :project_id => self.projects[3].id).first.amount
    #   
    #   if p.timer_expired
    #     p.round_payout = AMOUNT_USER_CAN_DONATE_PER_ROUND
    #   else
    #     p.round_payout = AMOUNT_USER_CAN_DONATE_PER_ROUND - @total
    #   end
    #   
    #   if self.projects[0].funded?
    #     p.round_payout += p.a_payout
    #   elsif @experiment.return_credits
    #     p.round_payout += Contribution.where(:user_id => p.user_id, :project_id => self.projects[0].id).first.amount
    #   end
    #   
    #   if self.projects[1].funded?
    #     p.round_payout += p.b_payout
    #   elsif @experiment.return_credits
    #     p.round_payout += Contribution.where(:user_id => p.user_id, :project_id => self.projects[1].id).first.amount
    #   end
    #   
    #   if self.projects[2].funded?
    #     p.round_payout += p.c_payout
    #   elsif @experiment.return_credits
    #     p.round_payout += Contribution.where(:user_id => p.user_id, :project_id => self.projects[2].id).first.amount
    #   end
    #   
    #   if self.projects[3].funded?
    #     p.round_payout += p.d_payout
    #   elsif @experiment.return_credits
    #     p.round_payout += Contribution.where(:user_id => p.user_id, :project_id => self.projects[3].id).first.amount
    #   end
    #   
    #   @user = User.find(p.user_id)
    #   @user.payout += p.round_payout
    #   
    #   @user.save!
    #   p.save!
    # end
    # 
    # self.finished = true
    # self.save!  
	end
	
	
end
