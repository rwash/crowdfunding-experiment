class Group < ActiveRecord::Base
	belongs_to :round
  has_one :experiment, :through => :round
	has_many :users, :through => :creator_preferences
	has_many :users, :through => :donor_preferences  
	has_many :creator_preferences
	has_many :donor_preferences
	has_many :projects, :dependent => :destroy 
	accepts_nested_attributes_for :projects, :allow_destroy => true   
	
	
end
