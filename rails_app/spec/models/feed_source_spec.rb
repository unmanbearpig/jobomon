require 'rails_helper'

RSpec.describe FeedSource do
  it { should validate_presence_of :feed }
  it { should validate_presence_of :source }
end
