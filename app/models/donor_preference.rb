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


  def calculate_total_return       # <TODO CL> Finish.
    @user = self.user                             
    @experiment = @user.experiment
    @group = self.group
    @total_return_from_projects = 0 
    @group.projects.each do |project| 
      if project.get_contribution(@user)
        @contribution = project.get_contribution(@user)
        if project.funded?
          if project.special_user_1 == @user.id || project.special_user_2 == @user.id
            @total_return_from_projects += project.special_return_amount
          else
            @total_return_from_projects += project.standard_return_amount
          end                                              
        else
          if @experiment.return_credits
            @total_return_from_projects += @contribution.amount
          end  
        end                                           
      end
    end 
    self.total_return = @total_return_from_projects + self.credits_not_donated  
    self.save!
  end
  
end      