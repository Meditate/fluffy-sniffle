FactoryBot.define do
  factory :comment do
    association :user, strategy: :build_stubbed
    association :commentable, factory: :movie, strategy: :build_stubbed
    body "MyText"
  end
end
