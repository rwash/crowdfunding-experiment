require 'spec_helper'
require 'helpers/login_helper_spec'
require 'helpers/experiment_helper_spec' 
require 'helpers/rounds_helper_spec'  


describe "CONTRIBUTING TO PROJECTS:" do

  before(:all) do
    @experiment = FactoryGirl.create(:experiment)
  end
  
  before :each do
    @user = User.first
    all_users_in_group_click_ready_to_start(@user)
    all_creators_in_group_have_their_turn(@user)
  end
  
  after(:all) do
    @experiment.destroy
  end

  context "When a Donor is Adding Contributions to Projects:" do  
    
    it "Cannot contribute more than the maximum allowed: #{AMOUNT_DONOR_CAN_DONATE_PER_ROUND} credits" do
      @user = User.where(:user_type => "Donor").first  
      @current_round = current_round
      login_user(@user)
      click_link("Start the First Round")     
      @current_round.projects.each_with_index do |project, i|
        fill_in "amount_#{i}", :with => AMOUNT_DONOR_CAN_DONATE_PER_ROUND
      end  
      click_button("Submit")    
      current_path.should eq(round_show_part_b_path(@current_round))
      page.should have_content("cannot exceed")
    end

    it "Cannot contribute any negative values" do
      @user = User.where(:user_type => "Donor").first  
      @current_round = current_round
      login_user(@user)
      click_link("Start the First Round")
      @current_round.projects.each_with_index do |project, i|
        fill_in "amount_#{i}", :with => (-1)
      end  
      click_button("Submit")
      current_path.should eq(round_show_part_b_path(@current_round))
      page.should have_content("Cannot contribute negative amounts!")    
    end
  end
end