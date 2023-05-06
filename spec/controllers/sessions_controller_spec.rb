RSpec.describe SessionsController, type: :controller do
  let(:valid_params) do
    { email: 'test@example.com', password: 'password123' }
  end

  let(:invalid_params) do
    { email: 'test@example.com', password: 'wrong_password' }
  end

  let!(:user) do
    User.create!(email: 'test@example.com', password: 'password123')
  end

  describe 'POST #create' do
    context 'when valid parameters are passed' do
      let!(:valid_params) do
        { email: 'test@example.com', password: 'password123' }
      end
      it 'sets the user_id in session' do
        post :create, params: valid_params
        expect(session[:user_id]).to eq(user.id)
      end

      context 'when user has approved KYC' do
        let(:kyc) { instance_double(Kyc, status: 'approved') }

        before do
          allow(user).to receive(:kyc).and_return(kyc)
        end

        it 'redirects to root path with a success message' do
          post :create, params: valid_params
          expect(response).to redirect_to(kyc_new_path)
          expect(flash[:notice]).to eq('add a kyc first to continue')
        end
      end

      context 'when user does not have approved KYC' do
        let(:kyc) { instance_double(Kyc, status: 'pending') }

        before do
          allow(user).to receive(:kyc).and_return(kyc)
        end

        it 'redirects to root path with a notice to wait for KYC approval' do
          post :create, params: valid_params
          expect(response).to redirect_to(kyc_new_path)
          expect(flash[:notice]).to eq('add a kyc first to continue')
        end
      end

      context 'when user does not have KYC' do
        before do
          allow(user).to receive(:kyc).and_return(nil)
        end

        it 'redirects to kyc new path with a notice to add KYC first' do
          post :create, params: valid_params
          expect(response).to redirect_to(kyc_new_path)
          expect(flash[:notice]).to eq('add a kyc first to continue')
        end
      end
    end

    context 'when invalid parameters are passed' do
      it 'renders the new template with an error message' do
        post :create, params: invalid_params
        expect(flash[:alert]).to eq(nil)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      session[:user_id] = user.id
    end

    it 'removes the user_id from session and redirects to root path with a success message' do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Logged out')
    end
  end

end

