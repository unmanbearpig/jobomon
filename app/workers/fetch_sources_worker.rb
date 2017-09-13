require 'sources'
require 'sidekiq'
require 'sidekiq-scheduler'

class FetchSourcesWorker
  include Sidekiq::Worker

  def perform
    Source.pluck(:id).each do |id|
      FetchJobOffersWorker.perform_async(id)
      logger.info "Scheduled source #{id}"
    end
  end
end
