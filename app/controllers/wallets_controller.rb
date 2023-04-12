class WalletsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :get_user

  def new
    @wallet = Wallet.new 
  end 

  def create 
      @wallet = Wallet.new(user_id: @user.id)
      if @wallet.save 
          redirect_to user_wallet_path, notice: "Successfully created wallet!"
      else 
          render :new 
      end 
  end 

  def show 

  end 


  private
    def get_user
      @user = Current.user
    end
end
