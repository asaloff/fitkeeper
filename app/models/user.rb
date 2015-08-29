class User < ActiveRecord::Base
  has_many :exercises
  has_many :workouts

  has_secure_password
end