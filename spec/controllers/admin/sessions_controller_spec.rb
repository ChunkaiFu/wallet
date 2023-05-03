# spec/controllers/admin/sessions_controller_spec.rb

require 'rails_helper'

module Admin
  RSpec.describe SessionsController, type: :controller do
    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST #create" do
      context "with valid admin credentials" do
        it "redirects to the admin dashboard" do
          post :create, params: { email: 'admin@example.com', password: 'password' }
          expect(response).to redirect_to(admin_dashboard_path)
        end

        it "sets the admin_authenticated session to true" do
          post :create, params: { email: 'admin@example.com', password: 'password' }
          expect(session[:admin_authenticated]).to be true
        end
      end

      context "with invalid admin credentials" do
        it "renders the new template" do
          post :create, params: { email: 'invalid@example.com', password: 'password' }
          expect(response).to render_template(:new)
        end

        it "sets the flash alert message" do
          post :create, params: { email: 'invalid@example.com', password: 'password' }
          expect(flash[:alert]).to eq('Invalid email or password')
        end

        it "does not set the admin_authenticated session" do
          post :create, params: { email: 'invalid@example.com', password: 'password' }
          expect(session[:admin_authenticated]).to be nil
        end
      end
    end

    describe "DELETE #destroy" do
      it "sets the admin_authenticated session to false" do
        delete :destroy
        expect(session[:admin_authenticated]).to be false
      end

      it "redirects to the root path" do
        delete :destroy
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
