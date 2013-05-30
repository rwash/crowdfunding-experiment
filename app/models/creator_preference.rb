class CreatorPreference < ActiveRecord::Base
  belongs_to :user
  belongs_to :round
  
  
  def set_ready_to_start
		self.is_ready = true
		self.save!
  end  
  
end
