require 'rails_helper'

RSpec.describe Source, type: :model do
  describe "validations" do
    subject { FactoryGirl.build(:source) }

    it { should validate_presence_of :url }
    it { should validate_uniqueness_of :url }
  end
end
