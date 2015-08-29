require 'rails_helper'

describe WorkoutsController do
  describe 'GET index' do
   before { set_current_user }

    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
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

    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: workout.id }
    end

    it "sets the @workout variable" do
      get :show, id: workout.id
      expect(assigns(:workout)).to eq workout
    end
  end

  describe 'GET new' do
    before { set_current_user }

    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end

    it 'sets the @workout variable' do
      get :new
      expect(assigns(:workout)).to be_a Workout
    end
  end
end
