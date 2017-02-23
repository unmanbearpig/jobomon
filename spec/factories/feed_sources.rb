FactoryGirl.define do
  factory :feed_source do
    feed { build :feed }
    source { build :source }
  end
end
