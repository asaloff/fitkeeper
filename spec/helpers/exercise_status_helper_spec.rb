require 'rails_helper'

describe ExerciseStatusHelper do 
  describe '#display_current_exercise_status(exercise)' do
    let(:sarah) { Fabricate(:user) }

    it "returns the excercise's current paramaters" do
      exercise = Exercise.create(name: 'Leg Day', user: sarah, weight: 10, time: 30, time_type: 'Seconds' ,sets: 5, reps: 10) 
      expect(display_current_exercise_status(exercise)).to eq '10 LBS, 30 Seconds, 5 Sets, 10 Reps'
    end

    it 'returns only two paramaters if the excercise has only two' do
      exercise = Exercise.create(name: 'Leg Day', user: sarah, weight: 10, reps: 10) 
      expect(display_current_exercise_status(exercise)).to eq '10 LBS, 10 Reps'
    end

    it 'returns only three paramaters if the excercise has only three' do
      exercise = Exercise.create(name: 'Leg Day', user: sarah, weight: 10, sets: 5, reps: 10) 
      expect(display_current_exercise_status(exercise)).to eq '10 LBS, 5 Sets, 10 Reps'
    end

    it 'does not return the time type if there is no time amount' do
      exercise = Exercise.create(name: 'Leg Day', user: sarah, weight: 10, sets: 5, reps: 10) 
      expect(display_current_exercise_status(exercise)).to eq '10 LBS, 5 Sets, 10 Reps' 
    end

    it 'does not have a comma at the front of the string' do
       exercise = Exercise.create(name: 'Leg Day', user: sarah, sets: 5, reps: 10) 
      expect(display_current_exercise_status(exercise)).to eq '5 Sets, 10 Reps' 
    end

    it 'does not have a comma at the end of the string' do
      exercise = Exercise.create(name: 'Leg Day', user: sarah, weight: 10, time: 30, time_type: 'Seconds' , sets: 5) 
      expect(display_current_exercise_status(exercise)).to eq '10 LBS, 30 Seconds, 5 Sets'
    end
  end
end