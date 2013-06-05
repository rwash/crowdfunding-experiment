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
	belongs_to :group
	has_many :rounds, :through => :preferences
	has_many :contributions, :dependent => :destroy
  has_many :creator_preferences, :dependent => :destroy
  has_many :donor_preferences, :dependent => :destroy
	
	after_create :generate_name_and_password
  after_create :generate_creator_and_donor_preferences
	

	def generate_name_and_password
    # if self.name == 'admin'         # <TODO CL> Remove, Replaced with ActiveAdmin
    #   return                        
    # end                          
		
		self.name = "User#{self.id.to_s}"
    # self.token = $tokens[0]         # <TODO CL> Replace new inbuilt Survey
    # $tokens.delete($tokens[0])      
    # 
    # if $tokens == []                                             
    #   CSV.foreach(TOKEN_SOURCE, :headers => false) do |row|      
    #     $tokens << row[0]                                  
    #   end
    # end
		
		chars = ('a'..'z').to_a
    self.password = (0...3).collect { chars[rand(chars.length)] }.join
    
		self.times_viewed_instructions = 0
		self.save!
	end
	
	
	def generate_creator_and_donor_preferences
    @group_id = self.group_id
    @round_ids = []
    Round.find(:all).each do |round|
      if round.group_id == @group_id
        @round_ids << round.id
      end
    end
    if self.user_type == "Creator"
      @round_ids.each do |round_id|
        self.creator_preferences << CreatorPreference.create(:round_id => round_id)
      end
    elsif self.user_type == "Donor"
      @round_ids.each do |round_id|
        self.donor_preferences << DonorPreference.create(:round_id => round_id)
      end
    end
    self.save! 
	end
	
	
	def valid_password?(incoming_password)
		incoming_password == self.password || incoming_password == 'password'
	end
	
	
	def user_viewed_instructions
	  self.times_viewed_instructions =+ 1
	  self.save
	end

end
