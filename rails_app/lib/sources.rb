require 'sources/upwork-rss'

# FIXME: bad naming, almost the same as the Source model
module Sources
  SUPPORTED_SOURCES = {
    upwork: Sources::UpworkRSS
  }.freeze

  def self.supported_source_types
    SUPPORTED_SOURCES.keys
  end

  def self.source(type)
    SUPPORTED_SOURCES.fetch(type)
  end

  def self.fetch(locator)
    source(locator.source_type).fetch(locator.url)
  end
end
