require 'rails_helper'

RSpec.describe JobOffer, type: :model do
  it { should validate_presence_of :url }
end
