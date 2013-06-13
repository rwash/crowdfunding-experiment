# ENVIRONMENTAL VARIABLES

# Rounds
NUMBER_OF_ROUNDS = 18
AMOUNT_USER_CAN_DONATE_PER_ROUND = 150

# Users
NUMBER_OF_CREATORS = 4
NUMBER_OF_DONORS = 8           
NUMBER_OF_USERS = NUMBER_OF_CREATORS + NUMBER_OF_DONORS
USER_PAYOUTS = [200, 150, 100, 50]    # <TODO CL> Is this redundant?
PROJECT_START_AMOUNTS = [300, 200, 100, 0]    # <TODO CL> Is this redundant?
CREDITS_TO_DOLLAR_RATE = 350  
                                                                
# Groups
NUMBER_OF_GROUPS = 2
NUMBER_OF_USERS_PER_GROUP = NUMBER_OF_USERS / NUMBER_OF_GROUPS    
NUMBER_OF_CREATORS_PER_GROUP = NUMBER_OF_CREATORS / NUMBER_OF_GROUPS
NUMBER_OF_DONORS_PER_GROUP = NUMBER_OF_DONORS / NUMBER_OF_GROUPS

# Projects
require 'csv'    
$project_names = []
CSV.foreach("colors4.csv", :headers => false) do |row|
  $project_names << row[0]
end

$project_names.each do |n|
	n.gsub!(";",'')
end


# if Rails.env.production?      # <TODO CL> Replace with inbuilt survey
#   TOKEN_SOURCE = 'tokens.csv'
# else
#   TOKEN_SOURCE = 'dummyTokens.csv'
# end

# $tokens = []                   # <TODO CL> Replace with inbuilt survey
# #CSV.foreach("tokens.csv", :headers => false) do |row|
# CSV.foreach(TOKEN_SOURCE, :headers => false) do |row|
#   $tokens << row[0]
# end