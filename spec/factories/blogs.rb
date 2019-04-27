
FactoryBot.define do
  factory :blog do
    title     { Faker::Lorem.sentence }
    content   { Faker::Lorem.paragraph }
    association :user, factory: :user
  end
end