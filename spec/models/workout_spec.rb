require 'rails_helper'

describe Workout do
  it { should belong_to :user }
  it { should have_and_belong_to_many :exercises }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end