class Group < ActiveRecord::Base
	belongs_to :experiment
	has_many :rounds, :dependent => :destroy
	has_many :users
  has_many :preferences
	
	after_create :genereate_rounds
	
	def genereate_rounds
		NUMBER_OF_ROUNDS.times do
			self.rounds << Round.create
		end
		self.save!
	end
	
	def generate_prefs
		self.rounds.each_with_index do |r,i|
			r.number = i + 1
			
			6.times do |j|
				@pref = Preferences.create
				# @pref.user_id = u.id
				@pref.kind_of = j + 1 #rand(1..6) # CHANGE BEFORE THE FINAL VERSION
				@pref.save!
				r.prefs << @pref
			end
			r.save!

		end
	end
end
