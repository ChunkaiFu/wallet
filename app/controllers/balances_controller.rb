class BalancesController < ApplicationController
  before_action :require_user_logged_in! 
  before_action :set_user
  before_action :set_wallet
  before_action :set_balance, only: [:show, :destroy, :edit, :update]
  before_action :require_kyc_exists, only: [:index, :show, :edit, :update]
  before_action :require_kyc_approved, only: [:index, :show, :edit, :update]
  def index
    if @wallet && @user.terms_of_service 
      @balances = @wallet.balances
    else 
      if !@wallet
        redirect_to new_wallet_path, alert: "Add some cards now" and return 
      elsif !@user.terms_of_service 
        redirect_to terms_path, alert: "please accept our terms first" and return 
      else 
        redirect_to wallet_balances_path, "You are good to go! Add some cards if you have not done so"
      end 
    end 
  end

  def show
    @balance = @wallet.balances.find_by(id: params[:id])
  end 

  def new
    if !@wallet 
      redirect_to new_wallet_path, alert: "Create a new wallet now"
    else 
      @cards=@wallet.cards
      if !@cards
        redirect_to wallet_cards_path, alert: "You need to add a card before adding cash"
      else 
        @balance = Balance.new
      end 
    end 
  end

  def edit 
    @balance = @wallet.balances.find_by(id: params[:id])
  end 

  def create
    @balances = @wallet.balances
    @cards = @wallet.cards 
    if !@cards 
      redirect_to wallet_cards_path, alert: "You need to add a card before adding cash"
    else  
      if @balances.any? { |balance| balance.currency == balance_params[:currency] }
        redirect_to wallet_balances_path, notice: 'Currency already exist.'
      else 
        @balance = @wallet.balances.new(balance_params)
        if @balance.save
          redirect_to wallet_balances_path, notice: 'Balance was successfully created.'
        else
          render :new
        end
      end
    end 
  end

  def update
    if !@balance
      redirect_to new_wallet_balance_path, alert: 'You do not have a currency, add one now!'
    elsif !@wallet.cards
      redirect_to wallet_cards_path, notice: "You need to add a card before adding cash"
    else 
      if @balance && balance_params[:value].to_f < 9999
        @balance.increment(:value, balance_params[:value].to_f)
        if @balance.save 
          redirect_to wallet_balances_path, notice: 'Balance was successfully updated.'
        end 
      else 
        flash[:alert] = "enter value less than 9999"
        render :edit  
      end
    end 
  end
  
  def destroy
    @balance = Balance.find(params[:id])
    @balance.destroy
    redirect_to wallet_balances_path, notice: 'Your balance has been trasferred to your debit account on file!'
  end

  private
    def balance_params
      params.require(:balance).permit(:id, :value, :currency, :wallet_id)
    end

    def set_user
      @user = Current.user
    end 

    def set_wallet
      @wallet = @user.wallet 
    end 

    def set_balance
      @balance = @wallet.balances.find_by(id: params[:id])
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
