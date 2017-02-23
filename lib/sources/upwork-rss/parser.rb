require 'feedjira'

module Sources
  class UpworkRSS
    class Parser
      def self.entries(data)
        feed = Feedjira::Feed.parse(data)
        feed.entries
      end
    end
  end
end
