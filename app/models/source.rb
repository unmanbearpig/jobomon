require 'sources'

class Source < ApplicationRecord
  validates :url, presence: true, allow_blank: false, uniqueness: true
  validates :source_type, presence: true, allow_blank: false,
            inclusion: { in: Sources.supported_source_types,
                         message: 'is not a supported type' }

  def source_type
    self[:source_type]&.to_sym
  end
end
