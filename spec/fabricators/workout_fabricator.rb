Fabricator(:workout) do
  name { Faker::Lorem.word }
  user_id { User.first.id }
end