require 'sources'

class Source < ApplicationRecord
  has_many :job_offers

  validates :url, presence: true, allow_blank: false, uniqueness: true
  validates :source_type, presence: true, allow_blank: false,
            inclusion: { in: Sources.supported_source_types,
                         message: 'is not a supported type' }

  scope(:old, -> { where('fetched_at is null or fetched_at < :time',
                         time: 10.minutes.ago) })

  def source_type
    self[:source_type]&.to_sym
  end

  def to_s
    "<#{source_type} \"#{title}\" (#{fetched_at}) at \"#{url}\">"
  end
end
