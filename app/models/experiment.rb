class Experiment < ActiveRecord::Base

	has_many :rounds, :dependent => :destroy
	has_many :users, :dependent => :destroy
	has_one :current_round, :class_name => 'Round'
	# has_one :admin
	
	after_create :generate_users
	after_create :generate_rounds
	after_create :generate_prefs
	
	def generate_users
		2.times do
			self.users << User.create(:name => "temp")
		end
		self.save!
	end
	
	def generate_rounds
		3.times do
			self.rounds << Round.create
		end
		self.save!
	end
	
	def generate_prefs
		self.rounds.each do |r|
			r.generate_and_assign_preferences
		end
	end
end
