class JobOffer < ApplicationRecord
  validates :url, presence: true, allow_blank: false
end
