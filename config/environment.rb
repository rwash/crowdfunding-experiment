# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CrowdfundingExperiment::Application.initialize!

NUMBER_OF_USERS_PER_GROUP = 2
NUMBER_OF_ROUNDS = 3
NUMBER_OF_GROUPS = 2
AMOUNT_USER_CAN_DONATE_PER_ROUND = 100

PROJECT_NAMES = ["Jakes Project", "Toms Project", "Bills Project", "Larrys Project"]