class UserSessionsController < InheritedResources::Base

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
    	redirect_to instructions_path
    else
      render :action => :new
    end
  end


  def destroy
    current_user_session.destroy unless current_user_session.nil?
    redirect_to root_path
  end
  
end