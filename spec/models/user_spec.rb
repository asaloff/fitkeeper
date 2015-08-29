require 'rails_helper'

describe User do
  it { should validate_presence_of :full_name }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }
  it { should have_secure_password }
  it { should have_many :exercises }
  it { should have_many :workouts }
end