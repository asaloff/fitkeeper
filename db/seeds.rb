# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.count == 0
  puts "adding users..."
  2.times { Fabricate(:user) } 
end

if Exercise.count == 0
  puts "adding exercises..."
  2.times { Fabricate(:exercise, user: User.first) }

  Fabricate(:exercise, user: User.first, time: nil, time_type: nil)
  Fabricate(:exercise, user: User.first, weight: nil, sets: nil)
end

if Workout.count == 0
  puts "adding workouts..."
  3.times { Fabricate(:workout, user: User.first) }
end

if Workout.first.exercises.count == 0
  puts "putting exercises in the first workout..."
  Exercise.all.each do |exercise|
    Workout.first.exercises << exercise
  end
end

puts "done"