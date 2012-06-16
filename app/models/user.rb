class User < ActiveRecord::Base
	
	belongs_to :session
	has_many :preferences
	has_many :rounds, :through => :session
	
	after_create :generate_name
	
	def generate_name
		self.name = "User " + self.id.to_s
		self.save!
	end
end
