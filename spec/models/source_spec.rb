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
end
