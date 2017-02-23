class UpdateOldSourcesWorker
  include Sidekiq::Worker

  def self.source_ids
    Source.old.pluck(:id)
  end

  def perform
    self.class.source_ids.each do |id|
      FetchJobOffersWorker.perform_async(id)
    end
  end
end
