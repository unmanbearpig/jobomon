FactoryGirl.define do
  factory :job_offer do
    source { build(:source) }
    title { Faker::Company.catch_phrase }
    url { Faker::Internet.url }
    content { Faker::Lorem.paragraph }
    published_at { Faker::Date.between(1.year.ago, 1.week.from_now) }
  end
end
