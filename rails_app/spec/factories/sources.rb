FactoryGirl.define do
  factory :source do
    title { Faker::Company.catch_phrase }
    url { Faker::Internet.url }
    source_type :upwork
  end
end
