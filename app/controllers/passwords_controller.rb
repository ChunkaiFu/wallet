class PasswordsController < ApplicationController
  before_action :require_user_logged_in! 

  def edit 
    @user = Current.user
    if @user.terms_of_service
      render :edit 
    else 
      redirect_to terms_path, alert: "please accept our terms first"
    end 
  end 


  def update 
    if Current.user.update(password_params)
      redirect_to root_path, notice: "Password Updated!"
    else 
      render :edit 
    end 
  end 


  private 

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end 
end 
