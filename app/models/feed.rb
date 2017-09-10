class Feed < ApplicationRecord
  has_many :feed_sources
  has_many :sources, through: :feed_sources
  has_many :job_offers, through: :sources

  validates :title, presence: true, allow_blank: false

  def to_s
    title
  end
end
