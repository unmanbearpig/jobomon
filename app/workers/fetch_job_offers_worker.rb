require 'sources'

class FetchJobOffersWorker
  include Sidekiq::Worker

  def self.fetch_source_id(source_id)
    source = Source.find(source_id)

    Sources.fetch(source).entries.each do |entry|
      source.job_offers << JobOffer.from_entry(entry)
    end

    source.fetched_at = Time.now

    source.save!
  end

  def perform(source_id)
    self.class.fetch_source_id(source_id)
  end
end