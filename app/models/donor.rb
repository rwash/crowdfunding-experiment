class Donor < ActiveRecord::Base
  belongs_to :user
  has_many :donor_preferences, :dependent => :destroy
  
end
