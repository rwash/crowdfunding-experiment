require 'spec_helper'


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


def current_round
  @experiment = current_experiment
  Round.where(:experiment_id => @experiment.id).order("number ASC").each do |round|
    return round unless round.round_complete
  end 
  return @experiment.rounds.first
end