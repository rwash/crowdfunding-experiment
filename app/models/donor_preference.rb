class DonorPreference < ActiveRecord::Base
  belongs_to :user
  belongs_to :round


  def set_ready_to_start
		self.is_ready = true
		self.save!
  end
  
  def check_if_finished_round
    redirect_to summary_waiting_path(@current_round) if self.finished_round
  end

end
