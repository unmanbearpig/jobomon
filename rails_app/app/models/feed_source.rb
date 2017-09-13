class FeedSource < ApplicationRecord
  belongs_to :feed
  belongs_to :source

  validates :feed, :source, presence: true

  def to_s
    "<Feed #{feed_id} <=> Source #{source_id}>"
  end
end
