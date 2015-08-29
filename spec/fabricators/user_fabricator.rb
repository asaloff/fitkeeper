Fabricator(:user) do
  full_name { Faker::Name.name }
  username { Faker::Internet.user_name(Faker::Name.name, %w(. _ -)) }
  password { 'password' }
end