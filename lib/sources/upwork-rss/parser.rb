require 'sources/entry'
require 'sources/feed'
require 'feedjira'

module Sources
  class UpworkRSS
    class Parser
      def self.parse_feed(data)
        construct_feed(Feedjira::Feed.parse(data))
      end

      def self.construct_feed(fj_feed)
        Feed.new(
          url: fj_feed.url,
          title: fj_feed.title,
          entries: fj_feed.entries.map(&method(:construct_entry)))
      end

      def self.construct_entry(fj_entry)
        Entry.new(url: fj_entry.url,
                  title: fj_entry.title,
                  content: fj_entry.content,
                  published_at: fj_entry.published)
      end
    end
  end
end
