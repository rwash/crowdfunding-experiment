# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CrowdfundingExperiment::Application.initialize!

NUMBER_OF_USERS_PER_GROUP = 6
NUMBER_OF_ROUNDS = 12
NUMBER_OF_GROUPS = 2
AMOUNT_USER_CAN_DONATE_PER_ROUND = 150
USER_PAYOUTS = [200,150,100,50]
PROJECT_START_AMOUNTS = [300,200,100,0]
CREDITS_TO_DOLLAR = 350

require 'csv'    
$project_names = []
CSV.foreach("colors4.csv", :headers => false) do |row|
  $project_names << row[0]
end

$project_names.each do |n|
	n.gsub!(";",'')
end

TOKENS = []
#CSV.foreach("tokens.csv", :headers => false) do |row|
CSV.foreach("dummyTokens.csv", :headers => false) do |row|
  TOKENS << row[0]
end