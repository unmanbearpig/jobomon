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
end
