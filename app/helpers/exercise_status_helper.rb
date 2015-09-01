module ExerciseStatusHelper
  def display_current_exercise_status(exercise)
    string = ''
    string << exercise.weight.to_s + ' LBS' if exercise.weight
    string << ', ' if (!string.empty?)  && (!string.strip.end_with?(',')) && (exercise.time || exercise.sets || exercise.reps)
    string << exercise.time.to_s + ' ' + exercise.time_type if exercise.time
    string << ', ' if !string.empty? && !string.strip.end_with?(',') && (exercise.sets || exercise.reps)
    string << exercise.sets.to_s + ' Sets' if exercise.sets
    string << ', ' if !string.empty?  && !string.strip.end_with?(',') && (exercise.reps)
    string << exercise.reps.to_s + ' Reps' if exercise.reps
    string
  end
end