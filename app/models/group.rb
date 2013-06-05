class Group < ActiveRecord::Base
	belongs_to :experiment
	has_many :rounds, :dependent => :destroy
	has_many :users
  has_many :preferences
	
	after_create :generate_rounds
	
	
	def generate_rounds
		1.upto(NUMBER_OF_ROUNDS) do |i|
			self.rounds << Round.create(:number => i)
		end
		self.save!
	end

	
  # def generate_prefs        # <TODO CL> Is this required anymore? Revise.
  #   self.rounds.each_with_index do |r,i|
  #     r.number = i + 1
  #     
  #     6.times do |j|
  #       @pref = Preferences.create
  #       # @pref.user_id = u.id
  #       @pref.kind_of = j + 1 #rand(1..6) # CHANGE BEFORE THE FINAL VERSION
  #       @pref.save!
  #       r.prefs << @pref
  #     end
  #     r.save!
  #   end
  # end

end
