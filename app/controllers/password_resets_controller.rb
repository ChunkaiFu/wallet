class PasswordResetsController < ApplicationController 
  def new 
  end 

  def create 
    @user = User.find_by(email: params[:email])

    if @user.present? 
      PasswordMailer.with(user: @user).reset.deliver_now
      redirect_to root_path, notice: "if an account with that email is found, we will send a link to reset your password."
    else 
      redirect_to root_path, notice: "if an account with that email is found, we will send a link to reset your password."
    end 
  end 

  def edit 
    @user = User.find_signed(params[:token], purpose: "password_reset")
    rescue activesupport::messageverifier::invalidsignature
    redirect_to sign_in_path, alert: "your token has expired. please try again."
  end 

  def update 
    @user = User.find_signed(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      user_id = @user.id 
      session[:user_id] = nil 
      redirect_to sign_in_path, notice: "your password was reset successfully. please sign in."
    else 
      render :edit 
    end 
  end 

  private 

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end 
end 
