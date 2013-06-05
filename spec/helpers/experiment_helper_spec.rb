require 'spec_helper'


def check_if_user_and_round_ready(preference, current_round)
  @preference = preference
  if !@preference.is_ready
    @preference.is_ready = true
    @preference.save!
    current_round.check_if_round_ready_to_start
  end    
end


def current_user_session
  return @current_user_session if defined?(@current_user_session)
  @current_user_session = UserSession.find
end


def current_user
  return @current_user if defined?(@current_user)
  @current_user = current_user_session && current_user_session.record
end


def current_experiment
	return @current_experiment if defined?(@current_experiment)
	@current_experiment = current_user.experiment
end


def current_group
	return @group if defined?(@group)
	@group = Group.find(current_user.group_id) # unless current_user.name == 'admin'  # <TODO CL> Remove?
end


def current_round
  @user = current_user
  @rounds_temp = []
  Round.where(:group_id => @user.group_id).each do |round|
    if !round.part_b_finished
      @rounds_temp << round
    end
  end
  @rounds_temp.sort_by{ |i| i[:number] }
  @current_round = @rounds_temp.first
end