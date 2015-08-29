module ApplicationHelper
  def options_for_every_five_to_hundred(exercise)
    options_for_select((1..100).select { |n| n % 5 == 0 }.map(&:to_s), exercise.weight.to_s)
  end

  def options_for_one_through_sixty(exercise)
    options_for_select((1..60).select {|n| n}.map(&:to_s), exercise.time.to_s)
  end

  def options_for_one_through_fifteen(exercise)
    options_for_select((1..15).select {|n| n}.map(&:to_s), exercise.reps.to_s)
  end

  def options_for_time_type
    options_for_select(["seconds", "minutes"])
  end
end
