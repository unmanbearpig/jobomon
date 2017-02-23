class JobOffer < ApplicationRecord
  belongs_to :source
  validates :url, :source, presence: true, allow_blank: false

  def self.from_entry(source_entry)
    new(source_entry.to_h)
  end
end
