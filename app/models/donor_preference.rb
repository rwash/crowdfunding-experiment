class DonorPreference < ActiveRecord::Base
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


  def calculate_total_return
    @user = self.user                             
    @experiment = @user.experiment
    @group = self.group
    @total_return_from_projects = 0 
    @credits_to_be_returned = 0
   
    @group.projects.each do |project| 
      if project.funded?
        if project.popularity == "Niche" && (project.special_user_1 == @user.id || project.special_user_2 == @user.id)
          @total_return_from_projects += project.special_return_amount
        else
          @total_return_from_projects += project.standard_return_amount
        end                                              
      else
        if @experiment.return_credits
          if project.get_contribution(@user)
            @contribution = project.get_contribution(@user) 
            @credits_to_be_returned += @contribution.amount 
          end
        end  
      end                                           
    end
    
    self.total_return_from_projects = @total_return_from_projects
    self.credits_to_be_returned = @credits_to_be_returned
    self.total_return = self.total_return_from_projects + self.credits_not_donated + self.credits_to_be_returned 
    self.save!
  end
  
end      