require 'rails_helper'

describe ExercisesController do
  describe 'GET index' do
    it_behaves_like "require_sign_in" do
      let(:action) { get :index}
    end

    it "sets the @exercises to all the current users exercises" do
      set_current_user
      exercise1 = Fabricate(:exercise, user: current_user)
      get :index
      expect(assigns(:exercises)).to eq current_user.exercises
    end
  end

  describe 'GET new' do
    before { set_current_user }
    let(:exercise) { Fabricate(:exercise) }

    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end

    it "sets the @exercise variable" do
      get :new
      expect(assigns(:exercise)).to be_a Exercise
    end
  end

  describe 'POST create' do
    it_behaves_like "require_sign_in" do
      let(:action) { post :create, Fabricate.attributes_for(:exercise) }
    end

    context 'with valid inputs' do
      before do
        set_current_user
        post :create, exercise: Fabricate.attributes_for(:exercise, user: nil)
      end

      it 'redirects to the exercise created success page' do
        expect(response).to redirect_to exercise_created_success_path
      end

      it "sets the exercise's user to the current user" do
        expect(Exercise.first.user).to eq current_user
      end

      it 'saves the exercise' do
        expect(Exercise.all.size).to eq(1)
      end
    end

    context 'without valid inputs' do
      before do
        set_current_user
        post :create, exercise: Fabricate.attributes_for(:exercise, name: nil)
      end

      it 'does not save the exercise' do
        expect(Exercise.all.size).to eq(0)
      end

      specify { should render_template(:new) }
    end
  end

  describe 'GET edit' do
    before { set_current_user }
    let(:exercise) { Fabricate(:exercise) }

    it_behaves_like "require_sign_in" do
      let(:action) { get :edit, id: exercise.id }
    end 

    it "sets @exercise" do
      get :edit, id: exercise.id 
      expect(assigns(:exercise)).to eq exercise
    end
  end

  describe 'PUT update' do
    before { set_current_user }
    let(:exercise) { Fabricate(:exercise, name: 'original-name', weight: 5) }

    it_behaves_like "require_sign_in" do
      let(:action) { put :update, id: exercise.id }
    end 

    context "with valid inputs" do
      before { put :update, id: exercise.id, exercise: { name: "second-name", weight: 15, time: "", time_type: "", sets: 15, reps: "" } }

      it 'redirects to the home page' do
        expect(response).to redirect_to home_path
      end

      it 'sets the @exercise variable' do
        expect(assigns(:exercise)).to eq exercise
      end

      it 'updates the exercise' do
        expect(assigns(:exercise).name).to eq "second-name"
        expect(assigns(:exercise).weight).to eq 15
      end

      it 'sets the flash message' do
        expect(flash["notice"]).to be_present
      end
    end

    context "without valid inputs" do
      before { put :update, id: exercise.id, exercise: { name: "Name", weight: "", time: "", time_type: "", sets: "", reps: "" } }
      
      it 'does not update the exercise' do
        expect(Exercise.first.name).to eq "original-name"
      end

      specify { should render_template(:edit) }
    end
  end

  describe 'DELETE destroy' do
    before { set_current_user }
    let(:exercise) { Fabricate(:exercise) }

    it_behaves_like "require_sign_in" do
      let(:action) { delete :destroy, id: exercise.id }
    end 

    it 'redirects to the home page' do
      delete :destroy, id: exercise.id
      expect(response).to redirect_to home_path
    end
    
    it 'deletes the exercise' do
      delete :destroy, id: exercise.id
      expect(Exercise.all.size).to eq(0)
    end
  end

  describe 'POST update_multiple' do
    let(:workout) { Fabricate(:workout, user: current_user) }
    let(:exercise1) { Fabricate(:exercise, user: current_user, name: "Legs", weight: 5, reps: 10, time: nil, time_type: nil) }
    let(:exercise2) { Fabricate(:exercise, user: current_user, name: "Back", weight: 10, reps: 15, time: nil, time_type: nil) }

    before do
      set_current_user
      workout.exercises << exercise1
      workout.exercises << exercise2
      post :update_multiple, "exercises"=> [{id: exercise1.id, name: "Legs", weight: 10, reps: 20}, {id: exercise2.id, name: "Back", weight: 20, reps: 10}]
    end

    it "redirect to the completed workout page" do
      expect(response).to redirect_to workout_complete_path
    end

    it "updates the exercises' parameters" do
      expect(exercise1.reload.weight).to eq(10)
      expect(exercise1.reload.reps).to eq(20)
      expect(exercise2.reload.weight).to eq(20)
      expect(exercise2.reload.reps).to eq(10)
    end
  end
end