class Creator < ActiveRecord::Base
  belongs_to :user
  has_many :creator_preferences, :dependent => :destroy
  
end
