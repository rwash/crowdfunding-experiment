require 'spec_helper'
require 'helpers/login_helper_spec'
require 'helpers/experiment_helper_spec'
require 'helpers/rounds_helper_spec'


describe "USERS COMPLETING A SINGLE ROUND:" do

  before(:all) do
    @experiment = FactoryGirl.create(:experiment)
  end
  
  after(:all) do
    @experiment.destroy
  end
  
  
  context "When all Users are ready to start:" do
    
    it "Starts Part A of the round - Only when all users have joined" do
      @user = User.first
      login_user(@user)
      current_round.part_a_started.should eq(false)
      all_users_in_group_click_ready_to_start(@user)
      login_user(@user)
      current_round.part_a_started.should eq(true)
    end
    
    it "Directs all Project Creators to the Part A show page" do
      @user = User.where(:user_type => "Creator").first
      all_users_in_group_click_ready_to_start(@user)
      @current_round = current_round
      @user = User.where(:user_type => "Creator").first
      login_user(@user)
      click_link("Start the First Round")
      current_path.should eq(round_show_part_a_path(@current_round))
    end
    
    it "Directs all Project Donors to the Waiting For Part B page" do
      @user = User.where(:user_type => "Donor").first
      all_users_in_group_click_ready_to_start(@user)
      @current_round = current_round
      @user = User.where(:user_type => "Donor").first
      login_user(@user)
      click_link("Start the First Round")
      current_path.should eq(waiting_for_part_b_path(@current_round))
    end
  end
  
  
  context "When all Creators are finished:" do

    before(:each) do
      @user = User.first
      all_users_in_group_click_ready_to_start(@user)
      all_creators_in_group_have_their_turn(@user)
    end

    it "Sets Part A of Round as Finished and Part B as Started" do
      current_round.part_a_finished.should eq(true)
      current_round.part_b_started.should eq(true)
    end
    
    it "Sets all Creators preferences to Finished" do
      @user = User.first
      @current_round = current_round
      User.where(:group_id => @user.group_id, :user_type => "Creator").each do |user|
        user.creator_preferences.where(:round_id => current_round).each do |preference|
          preference.finished_round.should eq(true)
        end
      end
    end
  end
  
  
  context "When all Donors are finished:" do
    
    before(:each) do
      @user = User.first
      all_users_in_group_click_ready_to_start(@user)
      all_creators_in_group_have_their_turn(@user)
      all_donors_in_group_have_their_turn(@user)
    end
    
    it "Sets Part B of Round as Finished, the End Time and Round as Complete" do
      @current_round = current_round
      @previous_round = Round.where(:group_id => @current_round.group_id, :number => (@current_round.number - 1)).first
      @previous_round.part_b_finished.should eq(true)
      @previous_round.end_time.should_not eq(nil)
      @previous_round.round_complete.should eq(true)
    end
    
    it "Sets all Donors preferences to Finished" do
      @user = User.first
      @current_round = current_round
      @previous_round = Round.where(:group_id => @current_round.group_id, :number => (@current_round.number - 1)).first
      User.where(:group_id => @user.group_id, :user_type => "Donor").each do |user|
        user.donor_preferences.where(:round_id => @previous_round).each do |preference|
          preference.finished_round.should eq(true)
        end
      end
    end
  end
end