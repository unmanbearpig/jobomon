require 'sources/entry'
require 'feedjira'

module Sources
  class UpworkRSS
    class Parser
      def self.entries(data)
        Feedjira::Feed.parse(data).entries.map(&method(:construct_entry))
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
