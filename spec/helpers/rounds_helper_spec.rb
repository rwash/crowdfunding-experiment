require 'spec_helper'


def all_users_in_group_click_ready_to_start(user)
  @user = user
  User.where(:group_id => @user.group_id).each_with_index do |user, i|
    login_user(user)
    click_link("Start the First Round")
  end
end


def all_creators_in_group_have_their_turn(user)
  @user = user
  User.where(:group_id => @user.group_id, :user_type => "Creator").each do |user|
    login_user(user)
    click_link("Start the First Round")
    click_button("Next")
  end
end


def all_donors_in_group_have_their_turn(user)
  @user = user
  User.where(:group_id => @user.group_id, :user_type => "Donor").each do |user|
    login_user(user)
    click_link("Start the First Round")
    click_button("Submit")
  end
end