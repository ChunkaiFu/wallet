require 'rails_helper'

RSpec.describe TermsOfServicesController, type: :controller do
    describe "GET #index" do
      context "when user is logged in" do
        let(:user) { FactoryBot.create(:user) }
        before do
            simulate_user_login(user)
          get :index
        end
  
        it "assigns the current user to @user" do
          expect(assigns(:user)).to eq(user)
        end
  
        it "renders the index template" do
          expect(response).to render_template(:index)
        end
      end
    end
  end
  