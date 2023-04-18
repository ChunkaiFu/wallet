class BalancesController < ApplicationController
  before_action :require_user_logged_in! 
  before_action :set_user
  before_action :set_wallet
  before_action :set_balance, only: [:show, :destroy, :edit, :update]

  def index
    if !@wallet
      redirect_to new_wallet_path, notice: "You need to add a card first"
    else 
      @balances = @wallet.balances
    end 
  end

  def show
    @balance = @wallet.balances.find_by(id: params[:id])
  end 

  def new
    if !@wallet 
      redirect_to new_wallet_path, notice: "Create a new wallet now"
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
      redirect_to new_wallet_balance_path, notice: 'You do not have a currency, add one now!'
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

end
