require 'tasks/support/print'

namespace :admin do
  desc "Show all feeds"
  task feeds: :environment do
    Print.(Feed)
  end

  desc "Show all sources"
  task sources: :environment do
    Print.(Source)
  end

  desc "feed_source_map"
  task feed_source_map: :environment do
    Print.(FeedSource)
  end

  desc "job offers"
  task job_offers: :environment do
    Print.(JobOffer)
  end

  desc "Show all"
  task dashboard: :environment do
    tasks = ['feeds', 'sources', 'feed_source_map', 'job_offers']

    tasks.each do |t|
      puts ''
      puts t.to_s.humanize + ':'
      Rake::Task['admin:' + t].invoke
    end
  end
end
