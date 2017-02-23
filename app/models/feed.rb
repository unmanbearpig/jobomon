class Feed < ApplicationRecord
  has_many :feed_sources
  has_many :sources, through: :feeds
end
