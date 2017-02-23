FactoryGirl.define do
  factory :feed do
    title { Faker::RockBand.name }
  end
end
