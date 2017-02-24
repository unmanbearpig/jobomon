module Sources
  class Entry
    ATTRIBUTES = [:url, :title, :raw_content, :published_at].freeze
    attr_reader *ATTRIBUTES

    def initialize(url:, title:, raw_content:, published_at:)
      @url = url
      @title = title
      @raw_content = raw_content
      @published_at = published_at
    end

    def to_h
      ATTRIBUTES.reduce({}) do |acc, attribute|
        acc[attribute] = self.public_send(attribute)
        acc
      end
    end
  end
end
