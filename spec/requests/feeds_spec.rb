require 'rails_helper'

RSpec.describe "Feeds", type: :request do
  def json_response
    JSON.parse(response.body)
  end

  describe "GET /feeds" do
    it "returns the list of all feeds" do
      feed = FactoryGirl.create(:feed, title: 'hello', url: 'https://example.com/test')

      get feeds_path

      expect(response).to have_http_status(200)
      expect(json_response)
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

    context "success" do
      it "creates a new feed" do
        expect do
          post feeds_path, params: { feed: feed_data }
        end.to change { Feed.count }.from(0).to(1)

        feed = Feed.first
        expect(feed.title).to eq('hello')
        expect(feed.url).to eq('https://example.com/test')

      end

      it "returns the created feed" do
        post feeds_path, params: { feed: feed_data }

        expect(response).to have_http_status(200)
        expect(json_response)
          .to eq('feed' =>
                 { 'id' => Feed.first.id,
                   'title' => 'hello',
                   'url' => 'https://example.com/test'})

      end
    end

    context "failure" do
      def make_bad_request
        post feeds_path, params: { feed: { hello: 'kitty' } }
      end

      it "doesn't touch the Feed" do
        expect do
          make_bad_request
        end.not_to change { Feed.count }
      end

      it "returns an error code" do
        make_bad_request
        expect(response).to have_http_status(400)
      end

      it "returns the message in JSON" do
        make_bad_request
        expect(json_response.fetch('error')).to match(/Url can't be blank/)
      end
    end
  end

  describe "GET /feeds/:id" do
    it "returns specified feed" do
      feed = FactoryGirl.create(:feed)

      get feed_path(feed.id, 'json')

      expect(response).to have_http_status(200)
      expect(json_response)
        .to eq('feed' => {
                 'id' => feed.id,
                 'url' => feed.url,
                 'title' => feed.title
               })

    end
  end
end
