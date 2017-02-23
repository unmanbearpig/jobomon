require 'sources/upwork-rss'

# FIXME: bad naming, almost the same as the Source model
module Sources
  SUPPORTED_SOURCES = {
    upwork: Sources::UpworkRSS
  }.freeze

  def self.supported_source_types
    SUPPORTED_SOURCES.keys
  end
end
