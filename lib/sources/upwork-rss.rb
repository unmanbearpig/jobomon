require_relative 'upwork-rss/fetcher'
require_relative 'upwork-rss/parser'

module Sources
  class UpworkRSS
    def self.fetch(url)
      parser.parse_feed fetcher.fetch(url).body
    end

    def self.fetcher
      Fetcher
    end

    def self.parser
      Parser
    end
  end
end
