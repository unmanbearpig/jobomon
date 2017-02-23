module Sources
  class Entry
    attr_reader :url, :title, :content, :published_at

    def initialize(url:, title:, content:, published_at:)
      @url = url
      @title = title
      @content = content
      @published_at = published_at
    end
  end
end
