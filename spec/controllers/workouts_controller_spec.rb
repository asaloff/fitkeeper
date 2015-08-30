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

  describe 'POST create' do
    before { set_current_user }

    let(:exercise1) { Fabricate(:exercise) }
    let(:exercise2) { Fabricate(:exercise) }

    it_behaves_like "require_sign_in" do
      let(:action) { post :create }
    end

    context 'with valid inputs' do
      before do
        workout = Fabricate(:workout)
        workout.exercises << exercise1
        post :create, workout: { name: "Leg Day", exercises: [exercise1.id, exercise2.id] } 
      end

      it "it redirects to the workouts page" do
        expect(response).to redirect_to workouts_path
      end

      it "adds the workout" do
        expect(Workout.all.size).to eq(2)
      end

      it "adds the workout to the current user's workouts" do
        expect(Workout.last.user_id).to eq(current_user.id)
      end

      it "puts the exercises in the workout" do
        expect(Workout.last.exercises).to match_array([exercise1, exercise2])
      end

      it 'does not add a duplicate exercise into a workout' do
        expect(Workout.last.exercises.size).to eq(2)
      end

      it "sets the flash" do
        expect(flash["notice"]).to eq "You've successfully added #{Workout.last.name.titleize}."
      end
    end

    context 'without valid inputs' do
      before { post :create, workout: { name: "", exercises: [exercise1.id, exercise2.id] } }

      specify { should render_template(:new) }

      it "does not save the workout" do
        expect(Workout.all.size).to eq(0)
      end
    end
  end

  describe 'GET edit' do
    before { set_current_user }
    let(:workout) { Fabricate(:workout) }

    it_behaves_like "require_sign_in" do
      let(:action) { get :edit, id: workout.id }
    end

    it 'sets the @workout variable to the selected workout' do
      get :edit, id: workout.id
      expect(assigns(:workout)).to eq workout
    end
  end

  describe 'PUT update' do
    before { set_current_user }
    let(:workout) { Fabricate(:workout) }
    let(:exercise1) { Fabricate(:exercise) }
    let(:exercise2) { Fabricate(:exercise) }
    let(:exercise3) { Fabricate(:exercise) }

    it_behaves_like "require_sign_in" do
      let(:action) { put :update, id: workout.id }
    end

    context 'with valid inputs' do
      before do
        workout.exercises << exercise3
        put :update, id: workout.id, workout: { name: workout.name, exercises: [exercise1.id, exercise2.id] } 
      end

      it 'redirects to the workouts page' do
        expect(response).to redirect_to workouts_path
      end

      it 'adds the new exercises and removes the unselected exercises from the workout' do
        expect(workout.exercises.size).to eq(2)
      end

      it 'sets the flash' do
        expect(flash["notice"]).to eq "#{workout.name.titleize} was edited successfully"
      end
    end

    context 'with invalid inputs' do
      before { put :update, id: workout.id, workout: { name: "", exercises: [exercise1.id, exercise2.id] }  }

      specify { should render_template(:edit) }

      it 'does not update the workout' do
        expect(workout.exercises.size).to eq(0) 
      end
    end
  end

  describe 'DELETE destroy' do
    let(:workout) { Fabricate(:workout) }
    before do 
      set_current_user
      delete :destroy, id: workout.id
    end

    it_behaves_like "require_sign_in" do
      let(:action) { delete :destroy, id: workout.id }
    end

    it 'redirects to the workouts page' do
      expect(response).to redirect_to workouts_path
    end

    it 'sets the @workout variable' do
      expect(assigns(:workout)).to eq workout
    end

    it 'deletes the workout' do
      expect(Workout.all.size).to eq(0)
    end
  end
end
