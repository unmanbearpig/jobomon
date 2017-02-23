class Feed < ApplicationRecord
  has_many :feed_sources
  has_many :sources, through: :feed_sources
  has_many :job_offers, through: :sources
end
