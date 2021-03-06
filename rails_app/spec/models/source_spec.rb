require 'rails_helper'

RSpec.describe Source, type: :model do
  describe "validations" do
    subject { FactoryGirl.build(:source) }

    it { should validate_presence_of :url }
    it { should validate_presence_of :source_type }
    it { should validate_uniqueness_of :url }

    it "validates source type" do
      subject = FactoryGirl.build(:source, source_type: 'hello')

      aggregate_failures do
        expect(subject).not_to be_valid
        expect(subject.errors[:source_type].count).to eq(1)
        expect(subject.errors[:source_type].first)
          .to match(/is not a supported type/)
      end
    end

    it "allows string as source type" do
      expect(FactoryGirl.build(:source, source_type: 'upwork'))
        .to be_valid
    end
  end

  describe ".old" do
    it "returns sources that were not updated recently" do
      FactoryGirl.create(:source, fetched_at: 2.minutes.ago)
      old_source = FactoryGirl.create(:source, fetched_at: 1.year.ago)
      new_source = FactoryGirl.create(:source, fetched_at: 1.minute.ago)

      expect(Source.old).to contain_exactly(old_source)
    end

    it "returns sources that were never fetched" do
      never_fetched = FactoryGirl.create(:source)

      expect(Source.old).to contain_exactly(never_fetched)
    end
  end
end
