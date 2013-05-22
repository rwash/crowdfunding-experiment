require 'spec_helper'

describe "v2.0 GENERATING A NEW EXPERIMENT:" do

  before(:all) do
    @experiment = FactoryGirl.create(:experiment)
  end
  
  after(:all) do
    @experiment.destroy
  end

  context "When Experiment Created:" do
    it "Should create (1) Experiment record" do
      Experiment.find(:all).uniq.count.should eq(1)
    end

    it "Should create (2) Group records & correct associations" do
      Group.find(:all).uniq.count.should eq(2)
      Group.where(:experiment_id == 1).count.should eq(2)  
    end

    it "Should create (36) Round records & correct associationss" do
      Round.find(:all).uniq.count.should eq(36)
      @group_ids = []
      Round.find(:all).each do |round|
        @group_ids << round.group_id
      end
      @group_ids.uniq.count.should eq(2)
    end

    it "Should create (144) Project records & correct associations" do
      Project.find(:all).uniq.count.should eq(144)      
      @round_id = []
      Project.find(:all).each do |project|
        @round_id << project.round_id
      end
      @round_id.uniq.count.should eq(36)
    end

    it "Should create (12) User records & correct associations" do
      User.find(:all).uniq.count.should eq(12)
      User.where(:experiment_id == 1).count.should eq(12)  
    end

    it "Should create (4) Creator records & correct associations" do
      Creator.find(:all).uniq.count.should eq(4)
    end

    it "Should create (8) Donor records & correct associations" do
      Donor.find(:all).uniq.count.should eq(8)
    end

    it "Should create (72) Creator_Preferences records & correct associations" do
      CreatorPreference.find(:all).uniq.count.should eq(72)      
    end
    
    it "Should create (144) Donor_Preferences records & correct associations" do
      DonorPreference.find(:all).uniq.count.should eq(144)      
    end

  end
end
