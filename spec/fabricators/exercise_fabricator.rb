Fabricator(:exercise) do
  name { Faker::Lorem.word }
  weight { Faker::Number.number(2) }
  time  { Faker::Number.between(1, 60) }
  time_type { 'seconds' }
  sets { Faker::Number.between(1, 10) }
  reps { Faker::Number.between(1, 15) }
  user { User.first }
end