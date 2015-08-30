module ApplicationHelper
  def options_for_weight(exercise)
    options_for_select((1..300).select { |n| n % 5 == 0 }.map(&:to_s), exercise.weight.to_s)
  end

  def options_for_time(exercise)
    options_for_select(one_through_sixty, exercise.time.to_s)
  end

  def options_for_time_type(exercise)
    options_for_select(["Seconds", "Minutes"], exercise.time_type)
  end

  def options_for_reps(exercise)
    options_for_select(one_through_sixty, exercise.reps.to_s)
  end

  def options_for_sets(exercise)
    options_for_select(one_through_fifteen, exercise.sets.to_s)
  end

  def one_through_sixty
    (1..60).select {|n| n}.map(&:to_s)
  end

  def one_through_fifteen
    (1..15).select {|n| n}.map(&:to_s)
  end
end
