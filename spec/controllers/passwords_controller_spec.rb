require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
    let(:user) { FactoryBot.create(:user) }
  
    before do
      login_user(user)
    end
  
    describe "GET #edit" do
      it "returns a successful response" do
        get :edit
        expect(response).to be_successful
      end
    end
  
    describe "PATCH #update" do
      context "with valid parameters" do
        let(:valid_params) { { user: { password: "new_password", password_confirmation: "new_password" } } }
  
        it "updates the user's password" do
          patch :update, params: valid_params
          expect(user.reload.authenticate(valid_params[:user][:password])).to eq(user)
        end
  
        it "redirects to the root path with a success message" do
          patch :update, params: valid_params
          expect(response).to redirect_to(root_path)
          expect(flash[:notice]).to eq("Password Updated!")
        end
      end
  
      context "with invalid parameters" do
        let(:invalid_params) { { user: { password: "new_password", password_confirmation: "different_password" } } }
  
        it "does not update the user's password" do
          expect { patch :update, params: invalid_params }.not_to change { user.reload.password_digest }
        end
  
        it "renders the edit template again" do
          patch :update, params: invalid_params
          expect(response).to render_template(:edit)
        end
      end
    end
  end
  