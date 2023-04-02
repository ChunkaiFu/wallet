class CardsController < ApplicationController
  before_action :require_user_logged_in! 
  before_action :set_card, only: [:edit, :update, :destroy]

  def index
    @cards = Current.user.cards
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Current.user.cards.build(card_params)
    if @card.save
      redirect_to cards_path, notice: 'Card was successfully created.'
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @card, notice: 'Card was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_url, notice: 'Card was successfully destroyed.'
  end

  private
    def set_card
      @card = Current.user.cards.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:issuer, :card_number, :expiration_date, :card_holder_name, :cvv)
    end
end
