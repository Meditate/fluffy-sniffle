FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Lorem.word }
    password { "password" }
    password_confirmation { "password" }
  end
end
