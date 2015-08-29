require 'rails_helper'

describe Exercise do
  it { should validate_presence_of :name}
  it { should validate_presence_of :user }

  it 'it does not save if no exercise paramaters are selected' do
    sarah = Fabricate(:user)
    Exercise.create(name: 'Leg Day', user: sarah, weight: nil, time: nil, sets: nil, reps: nil)
    expect(Exercise.count).to eq(0)
  end

  it 'it does not save if only one exercise paramaters is selected' do
    sarah = Fabricate(:user)
    Exercise.create(name: 'Leg Day', user: sarah, weight: 10, time: nil, sets: nil, reps: nil)
    expect(Exercise.count).to eq(0)
  end

  it 'saves if two paramaters are selected' do
    sarah = Fabricate(:user)
    Exercise.create(name: 'Leg Day', user: sarah, weight: 10, time: nil, sets: 10, reps: nil)
    expect(Exercise.count).to eq(1)
  end

  it 'does not save if time is selected but time_type is not' do
    sarah = Fabricate(:user)
    Exercise.create(name: 'Leg Day', user: sarah, weight: 10, time: 30, time_type: nil, sets: 10, reps: 10)
    expect(Exercise.count).to eq(0)
  end

  it 'does not save if time_type is selected but time is not' do
    sarah = Fabricate(:user)
    Exercise.create(name: 'Leg Day', user: sarah, weight: 10, time: nil, time_type: 'Seconds', sets: 10, reps: 10)
    expect(Exercise.count).to eq(0)
  end

  describe '#display_current_exercise_status' do
    let(:sarah) { Fabricate(:user) }

    it "returns the excercise's current paramaters" do
      exercise = Exercise.create(name: 'Leg Day', user: sarah, weight: 10, time: 30, time_type: 'seconds' ,sets: 5, reps: 10) 
      expect(exercise.display_current_exercise_status).to eq '10 lbs, 30 seconds, 5 sets, 10 reps'
    end

    it 'returns only two paramaters if the excercise has only two' do
      exercise = Exercise.create(name: 'Leg Day', user: sarah, weight: 10, reps: 10) 
      expect(exercise.display_current_exercise_status).to eq '10 lbs, 10 reps'
    end

    it 'returns only three paramaters if the excercise has only three' do
      exercise = Exercise.create(name: 'Leg Day', user: sarah, weight: 10, sets: 5, reps: 10) 
      expect(exercise.display_current_exercise_status).to eq '10 lbs, 5 sets, 10 reps'
    end

    it 'does not return the time type if there is no time amount' do
      exercise = Exercise.create(name: 'Leg Day', user: sarah, weight: 10, sets: 5, reps: 10) 
      expect(exercise.display_current_exercise_status).to eq '10 lbs, 5 sets, 10 reps' 
    end

    it 'does not have a comma at the front of the string' do
       exercise = Exercise.create(name: 'Leg Day', user: sarah, sets: 5, reps: 10) 
      expect(exercise.display_current_exercise_status).to eq '5 sets, 10 reps' 
    end

    it 'does not have a comma at the end of the string' do
      exercise = Exercise.create(name: 'Leg Day', user: sarah, weight: 10, time: 30, time_type: 'seconds' , sets: 5) 
      expect(exercise.display_current_exercise_status).to eq '10 lbs, 30 seconds, 5 sets'
    end
  end
end