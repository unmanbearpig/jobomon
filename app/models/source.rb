class Source < ApplicationRecord
  validates :url, presence: true, allow_blank: false, uniqueness: true
end
