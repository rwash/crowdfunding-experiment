# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CrowdfundingExperiment::Application.initialize!


# ********* THESE ENVIRONMENTAL VARIABLES ARE EDITABLE *********
NUMBER_OF_GROUPS = 2
NUMBER_OF_CREATORS_PER_GROUP = 2
NUMBER_OF_DONORS_PER_GROUP = 4
NUMBER_OF_ROUNDS = 18
AMOUNT_USER_CAN_DONATE_PER_ROUND = 150
USER_PAYOUTS = [200,150,100,50]
PROJECT_START_AMOUNTS = [300,200,100,0]
CREDITS_TO_DOLLAR = 350
# ***************************************************************


# DON'T TOUCH THESE
NUMBER_OF_USERS_PER_GROUP = NUMBER_OF_CREATORS_PER_GROUP + NUMBER_OF_DONORS_PER_GROUP

if Rails.env.production?
	TOKEN_SOURCE = 'tokens.csv'
else
	TOKEN_SOURCE = 'dummyTokens.csv'
end

require 'csv'    
$project_names = []
CSV.foreach("colors4.csv", :headers => false) do |row|
  $project_names << row[0]
end

$project_names.each do |n|
	n.gsub!(";",'')
end

$tokens = []
#CSV.foreach("tokens.csv", :headers => false) do |row|
CSV.foreach(TOKEN_SOURCE, :headers => false) do |row|
  $tokens << row[0]
end