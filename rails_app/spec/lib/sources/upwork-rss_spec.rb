require 'spec_helper'
require 'webmock/rspec'
require 'sources/upwork-rss'

module Sources
  RSpec.describe UpworkRSS do
    # Can't use real url because it contains a security token
    let(:sample_data) { File.read('spec/lib/sources/upwork-rss/rss-sample.xml') }
    let(:url) { 'https://www.upwork.com/ab/feed/topics/rss?orgUid=testuid&amp;securityToken=thesecuritytoken' }

    it "fetches something that looks correct" do
      stub_request(:get, url)
        .to_return(:status => 200, :body => sample_data, :headers => {})

      fetched_feed = UpworkRSS.fetch(url)
      expect(fetched_feed).to be_kind_of(Feed)
    end
  end
end
