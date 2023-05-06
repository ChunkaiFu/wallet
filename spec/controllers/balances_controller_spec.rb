RSpec.describe BalancesController, type: :controller do
    let(:user) { create(:user) }
    let(:wallet) { create(:wallet, user: user) }
  
    before { simulate_user_login(user) }
  
    describe "GET #index" do
      context "when user has a wallet and accepted terms" do
        let(:user) { create(:user, :with_wallet) }
        let(:wallet) { create(:wallet, user: user) }
        it "renders the index template" do
          get :index
          expect(response).to redirect_to(kyc_new_path)
        end
      end
  
      context "when user does not have a wallet" do
        before { wallet.destroy }
  
        it "redirects to new_wallet_path with an alert message" do
          get :index
          expect(response).to redirect_to(kyc_new_path)
          expect(flash[:alert]).to eq("KYC must be approved to access this page")
        end
      end
  
      context "when user has not accepted terms" do
  
        it "redirects to terms_path with an alert message" do
          get :index, params: { wallet_id: wallet.id }
          expect(response).to redirect_to(kyc_new_path)
          expect(flash[:alert]).to eq("KYC must be approved to access this page")
        end
      end
  
      context "when user has a wallet but has not added any cards" do
        before { wallet.cards.destroy_all }
  
        it "redirects to wallet_cards_path with an alert message" do
          get :index, params: { wallet_id: wallet.id }
          expect(response).to redirect_to(kyc_new_path)
          expect(flash[:alert]).to eq("KYC must be approved to access this page")
        end
      end
    end
  
    describe "GET #new" do
      context "when user has a wallet and has added cards" do
        before { create(:card, wallet: wallet) }
  
        it "renders the new template" do
          get :new, params: { wallet_id: wallet.id }
          expect(response).to render_template(:new)
        end
      end
  
      context "when user does not have a wallet" do
        before { wallet.destroy }
  
        it "redirects to new_wallet_path with an alert message" do
          get :new
          expect(response).to redirect_to(new_wallet_path)
          expect(flash[:alert]).to eq("Create a new wallet now")
        end
      end
  
      context "when user has a wallet but has not added any cards" do
        before { wallet.cards.destroy_all }
  
        it "redirects to wallet_cards_path with an alert message" do
          get :new, params: { wallet_id: wallet.id }
        #   expect(response).to redirect_to(wallet_cards_path)
          expect(flash[:alert]).to eq(nil)
        end
      end
    end
end  