class Contribution < ActiveRecord::Base
	belongs_to :project
	has_one :user
	has_one :round
end