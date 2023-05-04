require 'rqrcode'

class CardsController < ApplicationController
  before_action :require_user_logged_in! 
  before_action :set_user
  before_action :set_wallet
  before_action :set_card, only: [:show, :destroy]
  before_action :require_kyc_exists, only: [:index, :show, :edit, :update]
  before_action :require_kyc_approved, only: [:index, :show, :edit, :update]
  before_action :require_accept_terms, only: [:index, :show, :edit, :update]

  def index
    if @wallet && @user.terms_of_service 
      @cards = @wallet.cards
    else
      if !@wallet
        redirect_to new_wallet_path, alert: "create a wallet now" and return 
      elsif !@user.terms_of_service 
        redirect_to terms_path, alert: "please accept our terms first" and return 
      else 
        redirect_to wallet_cards_path, "You are good to go! Add some cards if you have not done so"
      end 
    end 
  end

  def show
    @card = @wallet.cards.find_by(id: params[:id])
    card_number = @card.number
    @qr = RQRCode::QRCode.new(card_number)
  end 

  def new
    @card = Card.new
  end

  def create
    @card = @wallet.cards.new(card_params)
    if @card.save
      redirect_to wallet_cards_path, notice: 'Card was successfully created.'
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to wallet_cards_path, notice: 'Card was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to wallet_cards_path, notice: 'Card was successfully destroyed.'
  end

  private
    def card_params
      params.require(:card).permit(:issuer, :number, :expiration_date, :holder_name, :cvv, :wallet_id)
    end

    def set_user
      @user = Current.user
    end 

    def set_wallet
      @wallet = @user.wallet 
    end 

    def set_card
      @card = @wallet.cards.find_by(id: params[:id])
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

    def require_accept_terms
      if !@user.terms_of_service
        redirect_to terms_path, alert: "please accept our terms first" and return 
      end 
    end 
end


