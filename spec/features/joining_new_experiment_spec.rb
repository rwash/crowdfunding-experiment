require 'spec_helper'
require 'helpers/login_helper_spec'
require 'helpers/experiment_helper_spec'

describe "JOINING A NEW EXPERIMENT:" do

  before(:all) do
    @experiment = FactoryGirl.create(:experiment)
  end
  
  before :each do
    @user = User.first
    login_user(@user)
  end
  
  after(:all) do
    @experiment.destroy
  end

  context "When first user joins a new experiment:" do
    it "Sets the Experiment Start Time and Started Property" do
      click_link("Start the First Round")
      current_experiment.start_time.should_not eq(nil)
      current_experiment.started.should eq(true)
    end
  
    it "Sets the current round as (1) for the experiment" do
      click_link("Start the First Round")
      current_round.number.should eq(1)
      current_path.should eq(round_waiting_path(current_round))
      current_experiment.current_round_number.should eq(current_round.number)
    end
  end
end