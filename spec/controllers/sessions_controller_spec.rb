require 'rails_helper'

describe SessionsController  do
  describe 'GET new' do
    it 'redirects to home page if there is an authenticated user' do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe 'POST create' do
    let(:sarah) { Fabricate(:user, username: 'sarah', password: 'password') }

    context 'with valid credentials' do
      before { post :create, username: sarah.username, password: sarah.password }

      it 'redirects to the home page' do
        expect(response).to redirect_to home_path
      end

      it 'sets the current user' do
        expect(session[:user_id]).to eq sarah.id
      end
    end

    context 'without valid credentials' do
      before { post :create, username: sarah.username, password: 'wrong' }

      it 'sets the flash' do
        expect(flash['danger']).to be
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to login_path
      end

      it 'does not set the current user' do
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe 'GET destroy' do
    before { set_current_user }
    before { get :destroy }

    it 'redirect to the login page' do
      expect(response).to redirect_to login_path
    end

    it 'takes the current user out of the session' do
      expect(session[:user_id]).to be_nil
    end
  end
end
