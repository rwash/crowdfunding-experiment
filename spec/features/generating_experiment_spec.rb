require 'spec_helper'

describe "GENERATING A NEW EXPERIMENT:" do

  before(:all) do
    @experiment = FactoryGirl.create(:experiment)
  end
  
  after(:all) do
    @experiment.destroy
  end

  context "When Experiment Created:" do
    it "Creates (1) Experiment record" do
      Experiment.find(:all).uniq.count.should eq(1)
    end

    it "Creates (#{NUMBER_OF_ROUNDS}) Round records & correct associations" do
      Round.find(:all).uniq.count.should eq(NUMBER_OF_ROUNDS)
      Round.where(:experiment_id == 1).count.should eq(NUMBER_OF_ROUNDS)
    end
    
    it "Creates (#{NUMBER_OF_GROUPS * NUMBER_OF_ROUNDS}) Group records & correct associations" do
      Group.find(:all).uniq.count.should eq(NUMBER_OF_GROUPS * NUMBER_OF_ROUNDS)
      Group.where(:experiment_id == 1).count.should eq(NUMBER_OF_GROUPS * NUMBER_OF_ROUNDS)
    end

    it "Creates (#{NUMBER_OF_USERS}) User records & correct associations" do
      User.find(:all).uniq.count.should eq(NUMBER_OF_USERS)
      User.where(:experiment_id == 1).count.should eq(NUMBER_OF_USERS)
      User.where(:user_type => "Creator").count.should eq(NUMBER_OF_CREATORS_PER_GROUP * NUMBER_OF_GROUPS)
      User.where(:user_type => "Donor").count.should eq(NUMBER_OF_DONORS_PER_GROUP * NUMBER_OF_GROUPS)
    end

    it "Creates (#{NUMBER_OF_CREATORS * NUMBER_OF_ROUNDS}) Creator_Preferences records & correct associations" do
      CreatorPreference.find(:all).uniq.count.should eq(NUMBER_OF_CREATORS * NUMBER_OF_ROUNDS)
      @round_id = []
      @group_id = Group.first.id
      CreatorPreference.find(:all).each do |creator_preference|
        @round_id << creator_preference.round_id
      end
      @round_id.uniq.count.should eq(NUMBER_OF_ROUNDS)
    end

    it "Creates (#{NUMBER_OF_DONORS * NUMBER_OF_ROUNDS}) Donor_Preferences records & correct associations" do
      DonorPreference.find(:all).uniq.count.should eq(NUMBER_OF_DONORS * NUMBER_OF_ROUNDS)
      @round_id = []
      @group_id = Group.first.id
      DonorPreference.find(:all).each do |donor_preference|
        @round_id << donor_preference.round_id
      end
      @round_id.uniq.count.should eq(NUMBER_OF_ROUNDS)
    end

    it "Creates (0) Project records" do
      Project.find(:all).uniq.count.should eq(0)      
    end

    it "Creates (0) Contribution Records" do
      Contribution.find(:all).uniq.count.should eq(0)         
    end
    
  end
end
