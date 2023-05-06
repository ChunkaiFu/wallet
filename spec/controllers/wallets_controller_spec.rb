RSpec.describe WalletsController, type: :controller do
    let(:user) { create(:user) }
  
    before { simulate_user_login(user) }
  
    describe "GET #new" do
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
  
    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new wallet and redirects to the wallet cards path" do
          post :create, params: { wallet: { user_id: user.id } }
          expect(response).to redirect_to(wallet_cards_path)
          expect(flash[:notice]).to eq("Successfully created wallet!")
        end
      end
  
      context "with invalid attributes" do
        it "renders the new template" do
          post :create, params: { wallet: { user_id: nil } }
          expect(response).to redirect_to(wallet_cards_path)
        end
      end
    end
  
    describe "GET #show" do
      it "renders the show template" do
        get :show
        expect(response).to redirect_to(kyc_new_path)
      end
    end
  
  end