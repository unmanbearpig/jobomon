FactoryGirl.define do
  factory :feed do
    title { Faker::Company.catch_phrase }
    url { Faker::Internet.url }
  end
end
