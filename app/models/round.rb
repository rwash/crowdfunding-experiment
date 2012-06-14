class Round < ActiveRecord::Base

	has_many :projects, :dependent => :destroy
	belongs_to :session
	
end
