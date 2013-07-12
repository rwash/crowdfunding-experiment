# ENVIRONMENTAL VARIABLES

# Rounds
NUMBER_OF_PRACTICE_ROUNDS = 3
NUMBER_OF_LIVE_ROUNDS = 15
TOTAL_NUMBER_OF_ROUNDS = NUMBER_OF_PRACTICE_ROUNDS + NUMBER_OF_LIVE_ROUNDS
AMOUNT_DONOR_CAN_DONATE_PER_ROUND = 150                    
ROUND_PART_A_COUNTDOWN_SECONDS = 60   
ROUND_PART_B_COUNTDOWN_SECONDS = 60
     

# Users
NUMBER_OF_CREATORS = 4
NUMBER_OF_DONORS = 8 
NUMBER_SPECIAL_DONORS_PER_GROUP = 2
NUMBER_OF_USERS = NUMBER_OF_CREATORS + NUMBER_OF_DONORS
CREDITS_TO_DOLLAR_RATE = 200  
    
                                                              
# Groups
NUMBER_OF_GROUPS = 2
NUMBER_OF_USERS_PER_GROUP = NUMBER_OF_USERS / NUMBER_OF_GROUPS    
NUMBER_OF_CREATORS_PER_GROUP = NUMBER_OF_CREATORS / NUMBER_OF_GROUPS
NUMBER_OF_DONORS_PER_GROUP = NUMBER_OF_DONORS / NUMBER_OF_GROUPS
NUMBER_STANDARD_DONORS_PER_GROUP = NUMBER_OF_DONORS_PER_GROUP - NUMBER_SPECIAL_DONORS_PER_GROUP 
      

# Projects
ALLOWED_NUMBER_OF_PROJECTS_PER_CREATOR = 3 
COST_TO_CREATE_PROJECT = 50  
AMOUNT_CREATOR_CAN_SPEND_PER_ROUND = ALLOWED_NUMBER_OF_PROJECTS_PER_CREATOR * COST_TO_CREATE_PROJECT   

HIGH_VALUE_PROJECT_GOAL = 200
STANDARD_RETURN_AMOUNT_HIGH_VALUE_POPULAR = 120
STANDARD_RETURN_AMOUNT_HIGH_VALUE_NICHE = 40
SPECIAL_RETURN_AMOUNT_HIGH_VALUE_NICHE = 200

LOW_VALUE_PROJECT_GOAL = 100   
STANDARD_RETURN_AMOUNT_LOW_VALUE_POPULAR = 60
STANDARD_RETURN_AMOUNT_LOW_VALUE_NICHE = 20
SPECIAL_RETURN_AMOUNT_LOW_VALUE_NICHE = 100  

CREATOR_EARNINGS_HIGH_VALUE_PROJECT = 200
CREATOR_EARNINGS_LOW_VALUE_PROJECT = 100 

require 'csv'    
$project_names = []
CSV.foreach("colors4.csv", :headers => false) do |row|
  $project_names << row[0]
end

$project_names.each do |n|
	n.gsub!(";",'')
end


# Text for Survey Questions
Q1_TEXT = "Select your age"
Q2_TEXT = "Select your gender"
Q3_TEXT = "Have you ever visited a crowdfunding website before?"
Q4_TEXT = "In the crowdfunding simulation, how many donors were trying to fund a set of projects at once?"
Q5_TEXT = "In the crowdfunding simulation, if a donor donated to a project and it did not get fully funded, were the donor's credits refunded?"
Q6_TEXT = "In the crowdfunding simulation, did you receive payouts for a completed project regardless of whether you donated to that project or not?"
Q7_TEXT_1 = "How risky was investment in these types of projects?"
Q7_TEXT_2 = "(1 = Not Risky, 5 = Moderately Risky, 10 = Extremely Risky)"
Q7_A_TEXT = "Project requires #{LOW_VALUE_PROJECT_GOAL} credits"
Q7_B_TEXT = "Project requires #{HIGH_VALUE_PROJECT_GOAL} credits"
Q8_TEXT = "Did you take any risks with your credits in this experiment?"
Q9_TEXT = "Were some projects more likely to be funded than others?  Please explain."
Q10_TEXT = "Were some projects too risky to invest in?  Please explain."
Q11_TEXT = "Including yourself, how many project creators were posting projects to the site in each round?"
Q12_TEXT_1 = "How risky was it to create each of the following types of projects?"
Q12_TEXT_2 = "(1 = Not Risky, 5 = Moderately Risky, 10 = Extremely Risky)"
Q12_A_TEXT = "A niche project that requires #{LOW_VALUE_PROJECT_GOAL} credits"
Q12_B_TEXT = "A niche project that requires #{HIGH_VALUE_PROJECT_GOAL} credits"
Q12_C_TEXT = "A popular project that requires #{LOW_VALUE_PROJECT_GOAL} credits" 
Q12_D_TEXT = "A popular project that requires #{HIGH_VALUE_PROJECT_GOAL} credits"   
SURVEY_RISK_SELECTION = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, "Not Sure"]
