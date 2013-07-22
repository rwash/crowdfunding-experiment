class SurveysController < ApplicationController                         
       
            
  def new
    @user = current_user
    if @user.survey
      redirect_to experiment_complete_path, :alert => "Survey already completed!"
    else
      @survey = Survey.new
      set_user_status(@user, "Completing the Experiment Survey")     
    end
  end
  
  
  def create
    @user = current_user
    # @survey = Survey.new(params[:survey])      
    if @user.survey
      redirect_to experiment_complete_path, :alert => "Survey already completed!"
    else
      @survey = Survey.new(params[:survey])
      if @survey.valid? 
        @survey.survey_complete = true
        @user.survey = @survey
        @user.save!
        set_user_status(@user, "Survey Completed - EXPERIMENT COMPLETE")       
        redirect_to experiment_complete_path, :notice => "Survey submitted!"
      else
        flash[:error] = "Please fill in all fields." 
        render "new"
      end
    end
  end
  
end
