class Round < ActiveRecord::Base

	belongs_to :experiment
	
	has_many :projects, :dependent => :destroy
	has_many :prefs, :class_name => 'Preferences'
	has_many :users, :through => :experiment
	has_many :contributions
	
	after_create :generate_projects
	
	def generate_projects
		4.times do
			self.projects << Project.create
		end
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
	
	def round_over
		self.projects.each do |p|
			p.funded_amount = 0
			p.contributions.each do |c|
				p.funded_amount += c.amount
			end
			p.save!
		end
	end
end
