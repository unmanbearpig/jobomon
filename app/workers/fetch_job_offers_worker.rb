require 'sources'

class FetchJobOffersWorker
  include Sidekiq::Worker

  def fetch_source_id(source_id)
    source = Source.find(source_id)

    unless source.present?
      raise "Could not find provided Source with id=#{source_id}"
    end

    entries = Sources.fetch(source).entries
    new_offers = entries
                   .map { |entry| jo = JobOffer.from_entry(entry); jo.source = source; jo }
                   .reject(&:duplicate?)

    new_offers.each do |offer|
      if offer.valid?
        source.job_offers << offer
      else
        logger.error "Getting offers: #{offer.inspect} is invalid. Error: #{offer.errors.full_messages}"
        logger.info "Invalid entry: #{entry.inspect}"
      end
    end

    logger.info "Fetched #{entries.count} entries from source #{source_id}, #{new_offers.count} of them are new offers"
    source.fetched_at = Time.now

    source.save!
  end

  def perform(source_id)
    fetch_source_id(source_id)
  end
end
