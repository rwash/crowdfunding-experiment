class Preferences < ActiveRecord::Base
	has_one :round
	has_one :user
end