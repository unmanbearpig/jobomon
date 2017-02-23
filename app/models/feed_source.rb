class FeedSource < ApplicationRecord
  belongs_to :feed
  belongs_to :source

  validates :feed, :source, presence: true
end
