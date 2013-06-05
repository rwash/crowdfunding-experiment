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

    it "Creates (#{NUMBER_OF_GROUPS}) Group records & correct associations" do
      Group.find(:all).uniq.count.should eq(2)
      Group.where(:experiment_id == 1).count.should eq(NUMBER_OF_GROUPS)
      @group_names = []
      Group.find(:all).each do |group|
        @group_names << group.name
      end
      @uniq_group_names = @group_names.uniq
      @uniq_group_names.count.should eq(NUMBER_OF_GROUPS)
    end

    it "Creates (#{NUMBER_OF_ROUNDS * NUMBER_OF_GROUPS}) Round records & correct associations" do
      Round.find(:all).uniq.count.should eq(NUMBER_OF_ROUNDS * NUMBER_OF_GROUPS)
      @group_ids = []
      Round.find(:all).each do |round|
        @group_ids << round.group_id
      end
      @group_ids.uniq.count.should eq(NUMBER_OF_GROUPS)
    end

    it "Creates (#{USERS_PER_EXPERIMENT}) User records & correct associations" do
      User.find(:all).uniq.count.should eq(USERS_PER_EXPERIMENT)
      User.where(:experiment_id == 1).count.should eq(USERS_PER_EXPERIMENT)
      User.where(:user_type => "Creator").count.should eq(NUMBER_OF_CREATORS_PER_GROUP * NUMBER_OF_GROUPS)
      User.where(:user_type => "Donor").count.should eq(NUMBER_OF_DONORS_PER_GROUP * NUMBER_OF_GROUPS)
    end

    it "Creates (#{NUMBER_OF_CREATOR_PREFERENCES}) Creator_Preferences records & correct associations" do
      CreatorPreference.find(:all).uniq.count.should eq(NUMBER_OF_CREATOR_PREFERENCES)
      @round_id = []
      @group_id = Group.first.id
      CreatorPreference.find(:all).each do |creator_preference|
        @round_id << creator_preference.round_id
      end
      @round_id.uniq.count.should eq(NUMBER_OF_ROUNDS * NUMBER_OF_GROUPS)
    end

    it "Creates (#{NUMBER_OF_DONOR_PREFERENCES}) Donor_Preferences records & correct associations" do
      DonorPreference.find(:all).uniq.count.should eq(NUMBER_OF_DONOR_PREFERENCES)
      @round_id = []
      @group_id = Group.first.id
      DonorPreference.find(:all).each do |donor_preference|
        @round_id << donor_preference.round_id
      end
      @round_id.uniq.count.should eq(NUMBER_OF_ROUNDS * NUMBER_OF_GROUPS)
    end

    it "Creates (0) Project records" do
      Project.find(:all).uniq.count.should eq(0)      
    end

    it "Creates (0) Contribution Records" do
      Contribution.find(:all).uniq.count.should eq(0)         
    end
    
  end
end
