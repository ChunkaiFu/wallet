class WalletsController < ApplicationController
  before_action :require_user_logged_in!
  before_action :get_user
  before_action :require_kyc_exists, only: [:index, :show, :edit, :update]
  before_action :require_kyc_approved, only: [:index, :show, :edit, :update]
  def new
    @wallet = Wallet.new 
  end 

  def create 
      @wallet = Wallet.new(user_id: @user.id)
      if @wallet.save 
          redirect_to wallet_cards_path, notice: "Successfully created wallet!"
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

    def require_kyc_exists
      @user = Current.user
      unless @user.kyc.present?
        flash[:alert] = "KYC must be approved to access this page"
        redirect_to kyc_new_path
      end
    end

    def require_kyc_approved
      @user = Current.user
      unless @user.kyc.status == "approved"
        flash[:alert] = "KYC status must be approved to access this page"
        redirect_to kyc_show_path
      end
    end
end
