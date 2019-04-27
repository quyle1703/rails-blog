
FactoryBot.define do
  factory :user do
    # first_name { Faker::Superhero.name }
    # last_name { Faker::Superhero.descriptor }
    email     { Faker::Internet.email }
    password   { '123456' }
    password_confirmation { '123456' }
  end
end