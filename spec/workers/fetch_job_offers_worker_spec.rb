require 'rails_helper'

RSpec.describe FetchJobOffersWorker do
  describe ".fetch_source_id" do
    it "fetches job offers from the source id and saves them" do
      source = FactoryGirl.create(:source)

      entries = [
        Sources::Entry.new(url: 'https://example.com',
                           title: 'test title',
                           content: 'test content',
                           published_at: 1.hour.ago)
      ]
      allow(Sources).to receive(:fetch).with(source)
                          .and_return(double(Sources::Feed, entries: entries))


      FetchJobOffersWorker.fetch_source_id(source.id)
    end
  end
end
