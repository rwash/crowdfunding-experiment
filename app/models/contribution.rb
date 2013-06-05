class Contribution < ActiveRecord::Base
	belongs_to :project
	belongs_to :user
	has_one :round
	
end