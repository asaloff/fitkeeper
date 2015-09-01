require 'rails_helper'

describe Exercise do
  it { should validate_presence_of :name}
  it { should validate_presence_of :user }

  describe 'validates for enough attributes' do
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
  end

  describe 'validates presence of time and time type together' do
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
  end
end