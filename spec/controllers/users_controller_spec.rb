require 'rails_helper'

describe UsersController do
    it 'redirects to the home page for already logged in users' do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end

  describe '#new' do
    it 'sets @user to a new instance of User' do
      get :new
      expect(assigns(:user)).to be_a User
    end
  end

  describe '#create' do
    context 'with valid inputs' do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it 'redirects to the home page' do
        expect(response).to redirect_to home_path
      end

      it 'saves the new user' do
        expect(User.all.size).to eq(1)
      end

      it 'puts the new user in the session' do
        expect(session[:user_id]).to eq User.first.id
      end

      it 'sets the success flash' do
        expect(flash["notice"]).to eq "Welcome #{current_user.full_name}! You've successfully registered."
      end
    end

    context 'with invalid inputs' do
      before { post :create, user: Fabricate.attributes_for(:user, full_name: "") }
      
      specify { should render_template(:new) }

      it 'does not save the new user' do
        expect(User.all.size).to eq(0)
      end
    end
  end
end
