class SessionsController < ApplicationController
  def create
    @user = User.find_by(Username: params[:Username])

    if !!@user && @user.authenticate(params[:Password])
      session[:user_id] = @user.id
      redirect_to user_path
    else
      message = "something went wrong! Please enter correct credentials"
      redirect_to login_path, notice: message
    end    
  end

  def home
    render :template=>'sessions/home'
  end  

end
