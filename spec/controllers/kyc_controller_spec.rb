require 'rails_helper'

RSpec.describe KycController, type: :controller do
    let(:user) { create(:user) }
  
    describe "GET #new" do
      context "when user is logged in" do
        before { simulate_user_login(user) }
  
        context "when user has a kyc" do
          let!(:kyc) { FactoryBot.create(:kyc, user: user) }
          before { simulate_user_login(user) }
  
          it "redirects to the kyc show page" do
            get :new
            expect(response).to redirect_to(kyc_show_path(kyc))
          end
        end
  
        context "when user doesn't have a kyc" do
          it "renders the new template" do
            get :new
            expect(response).to render_template(:new)
          end
        end
      end
  
      context "when user is not logged in" do
        it "redirects to the login page" do
          get :new
          expect(response).to redirect_to(sign_in_path)
        end
      end
    end


    describe "POST #create" do
    let(:user) { create(:user) }

    context "when the user has a KYC" do
      let!(:kyc) { FactoryBot.create(:kyc, user: user) }
      before { simulate_user_login(user) }

      it "redirects to the KYC show page" do
        post :create, params: { kyc: { status: 'pending', license_number: 'ABC123' } }
        expect(response).to redirect_to(kyc_show_path(kyc))
      end
    end

    context "when the user doesn't have a KYC" do
      before { simulate_user_login(user) }

      context "when the KYC is valid" do
        it "creates a new KYC and redirects to the KYC show page" do
          post :create, params: { kyc: { status: 'pending', license_number: 'ABC123' } }
          kyc = Kyc.last
          expect(kyc.user).to eq(user)
          expect(kyc.status).to eq("awaiting")
          expect(response).to redirect_to(kyc_show_path(kyc))
          expect(flash[:notice]).to eq("License added successfully")
        end
      end

    #   context "when the KYC is invalid" do
    #     it "renders the new KYC template" do
    #       post :create, params: { kyc: { status: 'pending', license_number: 'ABC123' } }
    #       expect(response).to render_template(:new)
    #     end
    #   end
    end

    context "when the user is not logged in" do
      it "redirects to the login page" do
        post :create, params: { kyc: { status: 'pending', license_number: 'ABC123' } }
        expect(response).to redirect_to(sign_in_path)
      end
    end
end

    describe "GET #show" do
    context "when the user has a KYC" do
      let(:user) { create(:user) }
      let!(:kyc) { FactoryBot.create(:kyc, user: user) }

      before do
        simulate_user_login(user)
        get :show
      end

    it "assigns the KYC to @kyc" do
        expect(assigns(:kyc)).to eq(kyc)
    end

    it "renders the KYC show template" do
        expect(response).to render_template(:show)
    end
    end

    context "when the user doesn't have a KYC" do
      let(:user) { create(:user) }

    before do
        simulate_user_login(user)
        get :show
    end

    it "assigns nil to @kyc" do
        expect(assigns(:kyc)).to be_nil
    end

    it "renders the KYC show template" do
        expect(response).to render_template(:show)
    end
    end

    context "when the user is not logged in" do
      before { get :show }

      it "redirects to the login page" do
          expect(response).to redirect_to(sign_in_path)
    end
    end
    end


end
    
