require 'spec_helper'
require 'sources/upwork-rss/parser'

module Sources
  RSpec.describe UpworkRSS::Parser do
    let(:sample_data) { File.read('spec/lib/sources/upwork-rss/rss-sample.xml') }
    subject(:entries) { UpworkRSS::Parser.entries(sample_data) }

    it "returns the correct number of entries" do
      expect(entries.count).to eq(30)
    end

    it "returns entries" do
      expect(entries.first).to be_kind_of(Entry)
    end

    it "returns the correct entries" do
      aggregate_failures do
        expect(entries.first.title)
          .to eq('Data Entry Easy Job!!! - Upwork')
        expect(entries.first.content)
          .to start_with('NOTE:: Top performing freelancers will receive more work!!!')
        expect(entries.first.url)
          .to eq('https://www.upwork.com/jobs/Data-Entry-Easy-Job_%7E0177f6b6f281c24a40?source=rss')

        expect(entries.last.title)
          .to eq('Senior Ruby on Rails Developer Needed - Upwork')
      end
    end
  end
end
