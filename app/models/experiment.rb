class Experiment < ActiveRecord::Base

	#has_many :rounds, :dependent => :destroy
	has_many :groups
	has_many :rounds, :through => :groups
	has_many :users, :dependent => :destroy
	# has_one :admin
	
	after_create :generate_groups
	after_create :generate_users
	after_create :set_current_round_and_generate_prefs
	after_create :mgaic_preferences
	
	def generate_users
		NUMBER_OF_USERS_PER_GROUP.times do
			@user1 = User.create(:name => "temp")
			self.users << @user1
			self.groups.first.users << @user1
			self.groups.first.save!
			
			@user2 = User.create(:name => "temp")
			self.users << @user2
			self.groups.last.users << @user2
			self.groups.last.save!
		end
		self.save!
	end
	
	def generate_groups
		self.groups << Group.create(:name => 'A')
		self.groups << Group.create(:name => 'B')
		self.save!
	end
	
	def set_current_round_and_generate_prefs
		self.groups.each do |g|
			g.generate_prefs
		end
		
		self.current_round_number = 1
		self.save!
	end
	
	def start_experiment
		self.started = true
		self.save!
	end
	
	def experiment_over
		self.users.each do |user|
			user.payout = 0
			@preferences = Preferences.where(:user_id => user.id)
			@preferences.each do |pref|
				user.payout += pref.round_payout
			end
			user.save!
		end
	
		self.finsihed_calc = true
		self.save!
	end
	
	def mgaic_preferences
		self.users.each_with_index do |u, i|
			NUMBER_OF_ROUNDS.times do |r|
				if i < 6 #first 6 people
					@rand = rand(0...2)
					@group = nil
					case @rand
					when 1
						@group = self.groups.first
					when 0
						@group = self.groups.last
					end
					
					@roundPrefs = @group.rounds.where(:number => r + 1).first.prefs					
					@prefs = @roundPrefs.where(:kind_of => ((r + i) % 6) + 1).first
					@prefs.user_id = u.id
					@prefs.save!
				else #last 6 people

					if self.groups.first.rounds.where(:number => r + 1).first.prefs.where(:kind_of => ((r + i) % 6) + 1).first.user_id.nil?
						@prefs = self.groups.first.rounds.where(:number => r + 1).first.prefs.where(:kind_of => ((r + i) % 6) + 1).first
						@prefs.user_id = u.id
						@prefs.save!
					elsif self.groups.last.rounds.where(:number => r + 1).first.prefs.where(:kind_of => ((r + i) % 6) + 1).first.user_id.nil?
						@prefs = self.groups.last.rounds.where(:number => r + 1).first.prefs.where(:kind_of => ((r + i) % 6) + 1).first
						@prefs.user_id = u.id
						@prefs.save!
					else
						qq = xx

					end

				end
			end
		end
	end
end
