require 'rails_helper'

RSpec.describe KycController, type: :controller do
  describe "GET #new" do
    context "when user is logged in" do
      login_user

      context "when kyc record exists" do
        let!(:kyc) { create(:kyc, user: @user) }

        it "redirects to kyc show page" do
          get :new
          expect(response).to redirect_to(kyc_show_path(kyc))
        end
      end

      context "when kyc record does not exist" do
        it "renders new template" do
          get :new
          expect(response).to render_template(:new)
        end
      end
    end

    context "when user is not logged in" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "POST #create" do
    context "when user is logged in" do
      login_user

      context "when kyc record exists" do
        let!(:kyc) { create(:kyc, user: @user) }
        let(:kyc_attributes) { attributes_for(:kyc, user: @user) }

        it "redirects to kyc show page" do
          post :create, params: { kyc: kyc_attributes }
          expect(response).to redirect_to(kyc_show_path(kyc))
        end
      end

      context "when kyc record does not exist" do
        let(:kyc_attributes) { attributes_for(:kyc, user: @user) }

        context "when kyc record is valid and status is 'pending'" do
          it "creates kyc record, updates status to 'awaiting', and redirects to kyc show page with success notice" do
            post :create, params: { kyc: kyc_attributes.merge(status: "pending") }
            kyc = Kyc.find_by(user: @user)

            expect(kyc).to be_present
            expect(kyc.status).to eq("awaiting")
            expect(flash[:notice]).to eq("License added successfully")
            expect(response).to redirect_to(kyc_show_path(kyc))
          end
        end

        context "when kyc record is invalid" do
          let(:invalid_kyc_attributes) { attributes_for(:kyc, user: @user, license_number: nil) }

          it "renders new template" do
            post :create, params: { kyc: invalid_kyc_attributes }
            expect(response).to render_template(:new)
          end
        end
      end
    end
  end
end
