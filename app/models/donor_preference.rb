class DonorPreference < ActiveRecord::Base
  belongs_to :donor
  belongs_to :round
  
end
