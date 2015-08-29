class User < ActiveRecord::Base
  has_many :exercises
  has_many :workouts

  has_secure_password

  validates_presence_of :full_name
  validates_presence_of :username
  validates_uniqueness_of :username
end