require 'rails_helper'
require 'sources/entry'

RSpec.describe JobOffer, type: :model do
  it { should validate_presence_of :url }
  it { should validate_presence_of :source }

  describe ".from_entry" do
    it "initializes new record from attributes of the provided object" do
      publish_date = 1.hour.ago

      entry = Sources::Entry.new(
        url: 'https://example.com',
        title: 'test title',
        content: 'test content',
        published_at: publish_date)

      job_offer = JobOffer.from_entry(entry)

      expect(job_offer.url).to eq('https://example.com',)
      expect(job_offer.title).to eq('test title',)
      expect(job_offer.content).to eq('test content',)
      expect(job_offer.published_at).to eq(publish_date)
    end
  end
end
