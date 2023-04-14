class CardsController < ApplicationController
  before_action :require_user_logged_in! 
  before_action :set_user
  before_action :set_wallet
  before_action :set_card, only: [:show, :destroy]

  def index
    @cards = @wallet.cards
  end

  def show
    @card = @wallet.cards.find_by(id: params[:id])
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

end


