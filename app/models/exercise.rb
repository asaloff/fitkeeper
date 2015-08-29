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

  def display_current_exercise_status
    string = ''
    string << weight.to_s + ' lbs' if weight
    string << ', ' if (!string.empty?)  && (!string.strip.end_with?(',')) && (time || sets || reps)
    string << time.to_s + ' ' + time_type if time
    string << ', ' if !string.empty? && !string.strip.end_with?(',') && (sets || reps)
    string << sets.to_s + ' sets' if sets
    string << ', ' if !string.empty?  && !string.strip.end_with?(',') && (reps)
    string << reps.to_s + ' reps' if reps
    string
  end
end
