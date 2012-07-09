class User < ActiveRecord::Base
	acts_as_authentic do |c|
		c.login_field = :name
		c.validate_email_field = false
	end
	
	belongs_to :experiment
	has_one :group
	has_many :preferences, :class_name => 'Preferences'
	has_many :rounds, :through => :preferences
	has_many :contributions
	
	after_create :generate_name_and_password
	
	def generate_name_and_password
		if self.name == 'admin'
			return
		end
		
		self.name = "User" + self.id.to_s
		self.token = $tokens[0]
		$tokens.delete($tokens[0])
		
		if $tokens == []
			CSV.foreach(TOKEN_SOURCE, :headers => false) do |row|
			  $tokens << row[0]
			end
		end
		
		chars = ('a'..'z').to_a
    self.password = (0...3).collect { chars[rand(chars.length)] }.join
    
		self.times_viewed_instructions = 0
		self.save!
	end
	
	def valid_password?(incoming_password)
		incoming_password == self.password || incoming_password == 'password'
	end

end
