class Experiment < ActiveRecord::Base

	has_many :rounds, :dependent => :destroy
	has_many :users, :dependent => :destroy
	has_one :current_round, :class_name => 'Round'
	# has_one :admin
	
	after_create :generate_users
	after_create :generate_rounds
	after_create :generate_prefs
	after_create :set_current_round
	
	def generate_users
		NUMBER_OF_USERS_PER_GROUP.times do
			self.users << User.create(:name => "temp")
		end
		self.save!
	end
	
	def generate_rounds
		NUMBER_OF_ROUNDS.times do
			self.rounds << Round.create
		end
		self.save!
	end
	
	def generate_prefs
		self.rounds.each_with_index do |r,i|
			r.number = i + 1
			r.generate_and_assign_preferences
		end
	end
	
	def set_current_round
		self.current_round = self.rounds.first
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
end
