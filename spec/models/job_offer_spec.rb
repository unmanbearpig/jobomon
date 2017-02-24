require 'rails_helper'
require 'sources/entry'

RSpec.describe JobOffer, type: :model do
  describe "validations" do
    subject { FactoryGirl.build(:job_offer) }

    it { should validate_presence_of :url }
    it { should validate_presence_of :source }
    it { should validate_uniqueness_of(:url).scoped_to(:source_id) }

    it "allows same urls on multiple sources" do
      s1, s2 = FactoryGirl.create(:source), FactoryGirl.create(:source)

      url = 'https://example.com'

      FactoryGirl.create(:job_offer, source: s1, url: url)
      expect(FactoryGirl.create(:job_offer, source: s2, url: url)).to be_valid
    end
  end

  describe ".from_entry" do
    it "initializes new record from attributes of the provided object" do
      publish_date = 1.hour.ago

      entry = Sources::Entry.new(
        url: 'https://example.com',
        title: 'test title',
        raw_content: 'test content',
        published_at: publish_date)

      job_offer = JobOffer.from_entry(entry)

      expect(job_offer.url).to eq('https://example.com',)
      expect(job_offer.title).to eq('test title',)
      expect(job_offer.content).to eq('test content',)
      expect(job_offer.published_at).to eq(publish_date)
    end
  end

  describe "content" do
    it "is updated automatically from raw content" do
      subject = FactoryGirl.build(:job_offer, content: nil, raw_content: 'test')
      expect(subject.content).to eq('test')
    end

    it "sanitizes html of raw content" do
      allow(SanitizeHTML).to receive(:call).and_return('-sanitized-')
      subject = FactoryGirl.build(:job_offer, content: nil, raw_content: 'test')
      expect(subject.content).to eq('-sanitized-')
    end

    it "returns content if avaliable" do
      subject = FactoryGirl.build(:job_offer, content: 'content', raw_content: 'raw')
      expect(subject.content).to eq('content')
    end

    it "automatically saves sanitized content" do
      subject = FactoryGirl.build(:job_offer, content: nil, raw_content: 'test')
      subject.content
      subject.save!

      expect(subject.read_attribute(:content)).to eq('test')
    end
  end
end
