require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new User instance to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) { { user: { email: "test@example.com", firstname: "John", lastname: "Doe", password: "password123", password_confirmation: "password123" } } }

      it "creates a new user" do
        expect { post :create, params: valid_params }.to change { User.count }.by(1)
      end

      it "redirects to the root path with a success message" do
        post :create, params: valid_params
        expect(response).to redirect_to(kyc_new_path)
        expect(flash[:notice]).to eq("Successfully created account!")
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { user: { email: "invalid_email", firstname: "John", lastname: "Doe", password: "password123", password_confirmation: "different_password" } } }

      it "does not create a new user" do
        expect { post :create, params: invalid_params }.not_to change { User.count }
      end

      it "renders the new template again" do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
end
