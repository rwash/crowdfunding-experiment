require 'spec_helper'

def login_user(user)
  visit root_path
  fill_in "user_session_name", :with => user.name
  fill_in "user_session_password", :with => user.password
  click_button "Login"
end