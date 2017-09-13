require 'spec_helper'
require 'vcr_helper'
require 'sources/upwork-rss/fetcher'

module Sources
  RSpec.describe UpworkRSS::Fetcher do
    it "fetches data over http", :vcr do
      response = UpworkRSS::Fetcher.fetch('http://example.com')
      expect(response.body).to match(/illustrative examples in documents/)
    end
  end
end
