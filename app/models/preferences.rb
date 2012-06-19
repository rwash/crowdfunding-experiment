class Preferences < ActiveRecord::Base
	has_one :round
	has_one :user
	
	validates :kind_of, :inclusion => 1..6
end