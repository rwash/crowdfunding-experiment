class SurveysController < ApplicationController                         
       
            
  def edit
    @user = current_user
    @survey = @user.survey
    set_user_status(@user, "Completing the Experiment Survey")     
  end
  
  
  def update 
    @user = current_user
    @survey = @user.survey
    if @survey.update_attributes(params[:survey]) 
      @survey.survey_complete = true
      @survey.save!
      set_user_status(@user, "Survey Completed - EXPERIMENT COMPLETE")       
      redirect_to experiment_complete_path
    else                   
      flash[:error] = "Please fill in all fields."
      render "edit"
    end
  end
  
end
