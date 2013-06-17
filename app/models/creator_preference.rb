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
    @experiment = @user.experiment
    @group = self.group
    @total_return_from_projects = 0 
    @credits_to_be_returned = 0
    
    @group.projects.each do |project|
      if project.user_id == @user.id
        if project.funded
          @total_return_from_projects += project.creator_earnings
        else
          if @experiment.return_credits
            @credits_to_be_returned += COST_TO_CREATE_PROJECT
          end
        end
      end
    end
    
    self.total_return_from_projects = @total_return_from_projects 
    self.credits_to_be_returned = @credits_to_be_returned         
    self.total_return = self.credits_not_spent + self.total_return_from_projects + self.credits_to_be_returned
    self.save!
  end
  
end         