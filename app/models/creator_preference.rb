class CreatorPreference < ActiveRecord::Base
  belongs_to :creator
  belongs_to :round
  
end
