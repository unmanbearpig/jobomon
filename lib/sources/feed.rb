module Sources
  class Feed
    attr_reader :url, :title, :entries
    def initialize(url:, title:, entries:)
      @url = url
      @title = title
      @entries = entries
    end
  end
end
