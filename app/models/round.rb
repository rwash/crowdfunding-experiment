class Round < ActiveRecord::Base

	belongs_to :group
	has_one :experiment, :through => :group
	has_many :projects, :dependent => :destroy
	has_many :prefs, :class_name => 'Preferences'
	has_many :users, :through => :prefs
	has_many :contributions
	
	after_create :generate_projects
	
	def check_if_all_done
		self.prefs.each do |p|
			if !p.finished_and_ready
				return false
			end
		end
		
		self.round_over
	end
		
	def generate_projects
		@project = Project.new
		@project.admin_name = 'A'
		@project.start_amount = PROJECT_START_AMOUNTS[0]
		@project.save!
		self.projects << @project

		@project = Project.new
		@project.admin_name = 'B'
		@project.start_amount = PROJECT_START_AMOUNTS[1]
		@project.save!
		self.projects << @project
		
		@project = Project.new
		@project.admin_name = 'C'
		@project.start_amount = PROJECT_START_AMOUNTS[2]
		@project.save!
		self.projects << @project
		
		@project = Project.new
		@project.admin_name = 'D'
		@project.start_amount = PROJECT_START_AMOUNTS[3]
		@project.save!
		self.projects << @project
		
		self.save!
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
