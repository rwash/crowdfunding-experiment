class Group < ActiveRecord::Base
	belongs_to :round
  has_one :experiment, :through => :round
	has_many :users, :through => :creator_preferences
	has_many :users, :through => :donor_preferences  
	has_many :creator_preferences
	has_many :donor_preferences
	has_many :projects, :dependent => :destroy 
	accepts_nested_attributes_for :projects, :allow_destroy => true   
	
	def has_user(user)
		self.users.where(id: user.id).exists?
	end	

  def cache_key
    proj_info = self.projects.map {|p| "#{p.id}-#{p.number_donors}"}.join("-")
    "groups/#{id}-#{proj_info}"
  end
end
