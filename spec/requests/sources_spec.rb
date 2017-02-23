require 'rails_helper'

RSpec.describe "Sources", type: :request do
  def json_response
    JSON.parse(response.body)
  end

  describe "GET /sources" do
    it "returns the list of all sources" do
      source = FactoryGirl.create(:source,
                                  title: 'hello',
                                  url: 'https://example.com/test',
                                  source_type: :upwork)

      get sources_path

      expect(response).to have_http_status(200)
      expect(json_response)
        .to eq('sources' => [{ 'id' => source.id,
                               'title' => 'hello',
                               'url' => 'https://example.com/test',
                               'source_type' => 'upwork' }])
    end
  end

  describe "POST /sources" do
    let(:source_data) do
      source_data = {
        title: 'hello',
        url: 'https://example.com/test',
        source_type: 'upwork'
      }
    end

    context "success" do
      it "creates a new source" do
        expect do
          post sources_path, params: { source: source_data }
        end.to change { Source.count }.from(0).to(1)

        source = Source.first
        expect(source.title).to eq('hello')
        expect(source.url).to eq('https://example.com/test')
      end

      it "returns the created source" do
        post sources_path, params: { source: source_data }

        expect(response).to have_http_status(200)
        expect(json_response)
          .to eq('source' =>
                 { 'id' => Source.first.id,
                   'title' => 'hello',
                   'url' => 'https://example.com/test',
                   'source_type' => 'upwork' })

      end
    end

    context "failure" do
      def make_bad_request
        post sources_path, params: { source: { hello: 'kitty' } }
      end

      it "doesn't touch the Source" do
        expect do
          make_bad_request
        end.not_to change { Source.count }
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

  describe "GET /sources/:id" do
    context "success" do
      it "returns specified source" do
        source = FactoryGirl.create(:source)

        get source_path(source.id, 'json')

        expect(response).to have_http_status(200)
        expect(json_response)
          .to eq('source' => {
                   'id' => source.id,
                   'url' => source.url,
                   'title' => source.title,
                   'source_type' => source.source_type.to_s
                 })

      end
    end

    context "failure" do
      it "returns the correct code" do
        get source_path(443242)

        expect(response).to have_http_status(404)
      end

      it "returns the error message" do
        get source_path(443242)

        expect(json_response.fetch('error')).to match(/Couldn't find/)
      end
    end
  end
end
