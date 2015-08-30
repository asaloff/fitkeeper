class Workout < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :exercises

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :user
end