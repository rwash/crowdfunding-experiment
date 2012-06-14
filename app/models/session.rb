class Session < ActiveRecord::Base

	has_many :rounds, :dependent => :destroy
	# has_many :users
	# has_one :admin
end
