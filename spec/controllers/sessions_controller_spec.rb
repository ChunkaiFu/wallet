require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid credentials" do
      it "sets the user_id in the session" do
        post :create, params: { email: user.email, password: user.password }
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to the root path with a success message" do
        post :create, params: { email: user.email, password: user.password }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Logged in successfully!")
      end
    end

    context "with invalid credentials" do
      it "sets a flash alert message" do
        post :create, params: { email: user.email, password: "wrongpassword" }
        expect(flash[:alert]).to eq("Invalid email or password!")
      end

      it "renders the new template" do
        post :create, params: { email: user.email, password: "wrongpassword" }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#destroy" do
    before { session[:user_id] = user.id }

    it "clears the user_id from the session" do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path with a success message" do
      delete :destroy
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq("Logged out")
    end
  end
end
