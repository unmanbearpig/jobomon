require 'spec_helper'
require 'sanitize_html'

RSpec.describe SanitizeHTML do
  describe "#call" do
    def expect_not_changed(html)
      expect(SanitizeHTML.(html)).to eq(html)
    end

    it "removes dangerous code" do
      example = <<-XSS
      <img src="javascript:alert(1)">
      XSS

      result = SanitizeHTML.(example)

      expect(result.strip).to eq('<img>')
      expect(result).not_to match(/javascript/)
      expect(result).not_to match(/alert/)
    end

    it "removes dangerous parts but keeps safe html" do
      example = <<-XSS
      <img src="javascript:alert(1)">

      <h1>hello</h1>
      XSS

      result = SanitizeHTML.(example)

      expect(result).not_to match(/javascript/)
      expect(result).not_to match(/alert/)

      expect(result).to match(/hello/)
      expect(result).to match(/<h1>hello<\/h1>/)
    end

    context "safe html" do
      it { expect_not_changed 'test' }
      it { expect_not_changed '<h1>hello</h1>' }
      it { expect_not_changed '<img src="https://example.com">' }
      it { expect_not_changed '<a href="https://example.com">test</a>' }
    end
  end
end
