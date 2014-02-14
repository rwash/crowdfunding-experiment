class User < ActiveRecord::Base
	acts_as_authentic do |c|
		c.login_field = :name
		c.validate_email_field = false
	end
  attr_accessible :name
  attr_accessible :password
  attr_accessible :user_type
  attr_accessible :payout
  attr_accessible :questions_payout
  attr_accessible :token
  attr_accessible :experiment_id
  attr_accessible :group_id
  attr_accessible :times_viewed_instructions
  attr_accessible :persistence_token
	belongs_to :experiment
	has_many :groups, :through => :creator_preferences
	has_many :groups, :through => :donor_preferences
	has_many :creator_preferences, :dependent => :destroy
  has_many :donor_preferences, :dependent => :destroy 
	has_many :projects, :dependent => :destroy 
	has_many :contributions, :dependent => :destroy
	has_one :survey, :dependent => :destroy

  scope :donors, -> {where(user_type: "Donor").order("id ASC")}
	
	after_create :generate_name_and_password       
	

	def generate_name_and_password
		self.name = "User#{self.id.to_s}"
		chars = ('a'..'z').to_a
    self.password = (0...3).collect { chars[rand(chars.length)] }.join
		self.times_viewed_instructions = 0
		self.save!
	end                          
	
	
	def valid_password?(incoming_password)
		incoming_password == self.password || incoming_password == 'password'
	end
	
	
	def user_viewed_instructions
	  self.times_viewed_instructions =+ 1
	  self.save
	end

  def order_number
    self.experiment.users.donors.index(self) + 1
  end

end
