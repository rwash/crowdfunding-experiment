class User < ActiveRecord::Base
	acts_as_authentic do |c|
		c.login_field = :name
		c.validate_email_field = false
	end
	
	belongs_to :experiment
	has_many :preferences
	has_many :rounds, :through => :experiment
	has_many :contributions
	
	after_create :generate_name_and_password
	
	def generate_name_and_password
		self.name = "User_" + self.id.to_s unless self.name == 'admin'
		self.password = "password"
		self.times_viewed_instructions = 0
		self.save!
	end
	
	def valid_password?(incoming_password)
		incoming_password == self.password
	end
end
