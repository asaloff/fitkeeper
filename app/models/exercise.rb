class Exercise < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :workouts

  validates_presence_of :name, :user
  validates_presence_of :time_type, if: 'time'
  validates_presence_of :time, if: 'time_type && !time_type.empty?'
  validate :at_least_two_params

  def at_least_two_params
    if  exercise_param_size == 0 || exercise_param_size == 1
      errors[:base] << ("Please choose at least two workout paramaters")
    end
  end 

  def exercise_param_size
    [self.weight, self.time, self.sets, self.reps].reject(&:blank?).size
  end
end
