class DonorPreference < ActiveRecord::Base   
  serialize :project_display_order
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

           
  def generate_project_display_order(group)
    @project_ids = []
    Project.where(:group_id => group).each do |project|  
      @project_ids << project.id
    end
    if @project_ids
      @randomized_project_list = @project_ids.shuffle
      self.project_display_order = @randomized_project_list
      self.save!   
    end
  end                                                                                 
  
  
  def get_project_list
    if self.project_display_order
      @project_id_list = self.project_display_order
      @group_projects = []
      @project_id_list.each do |id|
        @project = Project.find(id)
        @group_projects << @project
      end
      return @group_projects
    else
     return []
   end
  end


  def calculate_total_return
    @user = self.user                             
    @experiment = @user.experiment
    @group = self.group
    @total_return_from_projects = 0 
    @credits_to_be_returned = 0
   
    @group.projects.each do |project| 
      if project.funded?
        @total_return_from_projects += project.calculate_payout(@user, self, false)
      else
        if @experiment.return_credits
          if project.get_contribution(@user)
            @credits_to_be_returned += project.get_contribution(@user) 
          end
        end  
      end                                           
    end
    
    self.total_return_from_projects = @total_return_from_projects
    self.credits_to_be_returned = @credits_to_be_returned
    self.credits_not_donated = AMOUNT_DONOR_CAN_DONATE_PER_ROUND if self.credits_not_donated.nil?
    self.total_return = self.total_return_from_projects + self.credits_not_donated + self.credits_to_be_returned 
    self.save!
  end
  
end      