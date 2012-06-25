class Round < ActiveRecord::Base

	belongs_to :experiment
	
	has_many :projects, :dependent => :destroy
	has_many :prefs, :class_name => 'Preferences'
	has_many :users, :through => :experiment
	has_many :contributions
	
	after_create :generate_projects
		
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
	
	def generate_and_assign_preferences
		self.users.each_with_index do |u,i|
			@pref = Preferences.create
			@pref.user_id = u.id
			@pref.kind_of = rand(1..6) # CHANGE BEFORE THE FINAL VERSION
			@pref.save!
			self.prefs << @pref
		end
		self.save!
	end
	
	def round_started
		self.start_time = Time.now
		self.save!
	end
	
	def round_over
		self.end_time = Time.now
		self.save!
		
		self.projects.each do |p|
			p.funded_amount = p.start_amount
			p.contributions.each do |c|
				p.funded_amount += c.amount
			end
			p.save!
		end
		
		self.prefs.each do |p|
			p.round_payout = 0
			if self.projects[0].funded?
				p.round_payout += p.a_payout
			end
			if self.projects[1].funded?
				p.round_payout += p.b_payout
			end
			if self.projects[2].funded?
				p.round_payout += p.c_payout
			end
			if self.projects[3].funded?
				p.round_payout += p.d_payout
			end
			p.save!
		end
	end
end
