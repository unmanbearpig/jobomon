require_relative 'upwork-rss/fetcher'
require_relative 'upwork-rss/parser'

module Sources
  class UpworkRSS
    def self.fetcher
      Fetcher.new
    end

    def self.parser
      Parser.new
    end
  end
end
