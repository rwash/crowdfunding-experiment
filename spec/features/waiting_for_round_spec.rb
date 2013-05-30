require 'spec_helper'

describe "WAITING FOR ROUND:" do
  
  before(:all) do
    @experiment = FactoryGirl.create(:experiment)
  end
  
  after(:all) do
    @experiment.destroy
  end
  
  
  context "When checking for Users Ready" do
    
    it "Sets Round as Started once all assoicated Users are Ready" do
      @user = User.first
      @current_round = Round.where(:group_id => @user.group, :number => 1).first
      
  		if @user.user_type == "Creator"
  		  @preference = CreatorPreference.where(:user_id => @user, :round_id => @current_round).first
        @preference.set_ready_to_start unless @preference.is_ready
        @current_round.check_if_round_ready_to_start
  		elsif @user.user_type == "Donor"
        @preference = DonorPreference.where(:user_id => @user.id, :round_id => @current_round).first
        @preference.set_ready_to_start unless @preference.is_ready
        @current_round.check_if_round_ready_to_start
  		end

      # @preference.check_if_ready(@current_round)
      pp @preference.is_ready
      pp @preference.round.number
      pp @current_round
      # if !@preference.is_ready
      #   @preference.is_ready = true
      #   @preference.save!
      #   pp @preference
      #   @current_round.check_if_all_done
      #   
      #   @current_round.check_if_round_is_ready
      #   
      #   pp @current_round
      # end
    end
    
  end
end