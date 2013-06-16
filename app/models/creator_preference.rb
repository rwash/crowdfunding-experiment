class CreatorPreference < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :round
  
  
  def set_ready_to_start
		self.is_ready = true
		self.save!
  end  
  
  
  def set_finished_round
    self.finished_round = true
    self.save!
  end              
  
  
  def calculate_total_return       # <TODO CL> Finish.
    @user = self.user
    @group = self.group
    @total_return_from_projects = 0
    @group.projects.each do |project|
      if project.funded && project.user_id == @user.id
        @total_return_from_projects += project.creator_earnings
      end
    end
    self.total_return = self.credits_not_spent + @total_return_from_projects
    self.save!
  end
  
end
