require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  def test_email_validation(expectation, email)
    expect_errors = expect(
      FactoryGirl.build_stubbed(:user, email: email)
        .tap(&:valid?)
        .errors[:email])

    if expectation == :valid
      expect_errors.to be_blank
    elsif expectation == :invalid
      expect_errors.to eq(['is not a valid email'])
    else
      raise "invalid expectation argument #{expectation.inspect}, expected either :valid or :invalid"
    end
  end

  it 'validates email format' do
    test_email_validation(:valid, 'a@b.cd')
    test_email_validation(:valid, 'a-b@b-x.cd')
    test_email_validation(:valid, 'a+x@b.cd')
    test_email_validation(:invalid, 'test')
    test_email_validation(:invalid, 'test.com')
    test_email_validation(:invalid, '@test.com')
    test_email_validation(:invalid, 'test@')
  end
end
