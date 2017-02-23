require 'sources/upwork-rss'

module Sources
  SUPPORTED_SOURCES = {
    upwork: Sources::UpworkRSS
  }.freeze

  def self.supported_source_types
    SUPPORTED_SOURCES.keys
  end
end
