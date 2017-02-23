require 'rails_helper'

RSpec.describe Feed do
  describe "#job_offers" do
    it "queries job offers through its sources" do
      feed = FactoryGirl.create(:feed)
      s1 = FactoryGirl.create(:source)
      s2 = FactoryGirl.create(:source)
      FactoryGirl.create(:feed_source, feed: feed, source: s1)
      FactoryGirl.create(:feed_source, feed: feed, source: s2)
      jo1 = FactoryGirl.create(:job_offer, source: s1)
      jo2 = FactoryGirl.create(:job_offer, source: s2)

      expect(feed.job_offers).to contain_exactly(jo1, jo2)
    end
  end
end
