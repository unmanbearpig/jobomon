require 'rails_helper'

RSpec.describe "Feeds", type: :request do
  describe "GET /feeds" do
    it "returns the list of all feeds" do
      feed = FactoryGirl.create(:feed, title: 'hello', url: 'https://example.com/test')

      get feeds_path('json')

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body))
        .to eq('feeds' => [{'id' => feed.id,
                            'title' => 'hello',
                            'url' => 'https://example.com/test'}])
    end
  end

  describe "POST /feeds" do
    let(:feed_data) do
      feed_data = {
        title: 'hello',
        url: 'https://example.com/test'
      }
    end

    it "creates a new feed" do
      expect do
        post feeds_path('json'), feed: feed_data
      end.to change { Feed.count }.from(0).to(1)

      feed = Feed.first
      expect(feed.title).to eq('hello')
      expect(feed.url).to eq('https://example.com/test')

    end

    it "returns the created feed" do
      post feeds_path('json'), feed: feed_data

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body))
        .to eq('feed' => {'id' => Feed.first.id,
                          'title' => 'hello',
                          'url' => 'https://example.com/test'})

    end
  end
end
