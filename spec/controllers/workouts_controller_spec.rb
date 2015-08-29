require 'rails_helper'

describe WorkoutsController do
  describe 'GET index' do
   before { set_current_user }

    it "redirects to the sign in page for unauthenticated users" do
      clear_current_user
      get :index
      expect(response).to redirect_to login_path
    end

    it "sets @workouts to all of the current user's workouts" do
      workout1 = Fabricate(:workout, user: current_user)
      workout2 = Fabricate(:workout, user: current_user)
      get :index
      expect(assigns(:workouts)).to match_array([workout1, workout2])
    end
  end

  describe 'GET show' do
    before { set_current_user }
    let(:workout) { Fabricate(:workout) }

     it "redirects to the sign in page for unauthenticated users" do
      clear_current_user
      get :show, id: workout.id
      expect(response).to redirect_to login_path
    end

    it "sets the @workout variable" do
      get :show, id: workout.id
      expect(assigns(:workout)).to eq workout
    end
  end
end
