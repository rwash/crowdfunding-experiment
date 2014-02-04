class UserSessionsController < InheritedResources::Base

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      path = nil
      if current_user.user_type == "Creator"
        current_user_session.destroy unless current_user_session.nil?
        path = root_path
      else
    	 path = welcome_path
      end
      redirect_to(path) and return
    else                    
      flash[:error] = "Incorrect Login Details"
      render :action => :new
    end
  end


  def destroy
    current_user_session.destroy unless current_user_session.nil?
    redirect_to root_path
  end
  
end