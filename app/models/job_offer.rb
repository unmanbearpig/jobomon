require 'sanitize_html'

class JobOffer < ApplicationRecord
  belongs_to :source, touch: true
  validates :url, :source, presence: true, allow_blank: false
  validates :url, uniqueness: { scope: :source_id }

  def self.from_entry(source_entry)
    new(source_entry.to_h)
  end

  def content
    self[:content] ||= SanitizeHTML.(raw_content)
  end

  def to_s
    "(#{updated_at}) #{title}"
  end

  def duplicate?
    source.job_offers.where(url: url).any?
  end
end
