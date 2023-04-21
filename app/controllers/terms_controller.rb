class TermsController < ApplicationController
  before_action :require_user_logged_in! 
  before_action :set_user

  def new 
  end 

  def edit 
    @user =Current.user
  end 

  def create 
    @user = Current.user 
  end 

  # def update
  #   @user =Current.user
  #   if @user.update(term_params)
  #     @user.assign_attributes(terms_of_service: term_params[:terms_of_service])
  #     redirect_to wallet_cards_path, notice: "you are good to go! add some cards if you have not already"
  #   else 
  #     render :edit
  #   end 
  # end 

  def update
    @user = Current.user
    random_password = SecureRandom.hex(10)
    if @user.update(terms_of_service: term_params[:terms_of_service], password: random_password, password_confirmation: random_password)
      redirect_to wallet_cards_path, notice: "you are good to go! remember to always have a card on file"
    else
      render :edit
    end
  end


  private 

  def set_user 
    @user = Current.user
  end 

  def term_params
    params.require(:user).permit(:terms_of_service)
  end 

end 
