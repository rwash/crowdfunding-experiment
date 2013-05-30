class Round < ActiveRecord::Base

	belongs_to :group
	has_one :experiment, :through => :group
	has_many :projects, :dependent => :destroy
	has_many :prefs, :class_name => 'Preferences'       # <REMOVE CL>  Once new preferences implemented
	has_many :users, :through => :prefs
	has_many :contributions
	
	has_many :creator_preferences
	has_many :donor_preferences

	
	def check_if_round_ready_to_start
    self.creator_preferences.each do |creator_preference|
      return false if !creator_preference.is_ready
    end
    self.donor_preferences.each do |donor_preference|
      return false if !donor_preference.is_ready
    end
    self.part_a_started = true
    self.save!
  end
  
	
	def check_if_all_done
		self.prefs.each do |p|
			if !p.finished_and_ready
				return false
			end
		end
		
		self.round_over
	end

	
	def round_started
		self.start_time = DateTime.now
		self.save!
	end
	
	
	def round_over
		self.end_time = DateTime.now
		self.save!
		
		self.projects.each do |p|
			p.funded_amount = p.start_amount
			p.contributions.each do |c|
				p.funded_amount += c.amount
			end
			p.save!
		end
		
		@experiment = self.experiment
			
		self.prefs.each do |p|
			p.round_payout = 0
			
			@total = 0

			@total = Contribution.where(:user_id => p.user_id, :project_id => self.projects[0].id).first.amount + Contribution.where(:user_id => p.user_id, :project_id => self.projects[1].id).first.amount + Contribution.where(:user_id => p.user_id, :project_id => self.projects[2].id).first.amount + Contribution.where(:user_id => p.user_id, :project_id => self.projects[3].id).first.amount
			
			if p.timer_expired
				p.round_payout = AMOUNT_USER_CAN_DONATE_PER_ROUND
			else
				p.round_payout = AMOUNT_USER_CAN_DONATE_PER_ROUND - @total
			end
			
			if self.projects[0].funded?
				p.round_payout += p.a_payout
			elsif @experiment.return_credits
				p.round_payout += Contribution.where(:user_id => p.user_id, :project_id => self.projects[0].id).first.amount
			end
			
			if self.projects[1].funded?
				p.round_payout += p.b_payout
			elsif @experiment.return_credits
				p.round_payout += Contribution.where(:user_id => p.user_id, :project_id => self.projects[1].id).first.amount
			end
			
			if self.projects[2].funded?
				p.round_payout += p.c_payout
			elsif @experiment.return_credits
				p.round_payout += Contribution.where(:user_id => p.user_id, :project_id => self.projects[2].id).first.amount
			end
			
			if self.projects[3].funded?
				p.round_payout += p.d_payout
			elsif @experiment.return_credits
				p.round_payout += Contribution.where(:user_id => p.user_id, :project_id => self.projects[3].id).first.amount
			end
			
			@user = User.find(p.user_id)
			@user.payout += p.round_payout
			
			@user.save!
			p.save!
		end
		
		self.finished = true
		self.save!	
	end
	
	
end
