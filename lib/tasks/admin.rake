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

  namespace :job_offers do
    desc 'Latest offers'
    task latest: :environment do
      Print.(JobOffer.order(created_at: :desc).take(10).reverse)
    end
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

  namespace :sources do
    desc 'Fetch all sources'
    task fetch: :environment do
      Source.pluck(:id).each do |id|
        FetchJobOffersWorker.perform_async(id)
        puts "Scheduled source #{id}"
      end
    end
  end

  namespace :source do
    desc "Add source"
    task :add, [:source_type, :title, :url] => :environment do |_t, args|
      Print.(Source.create!(
               source_type: args.fetch(:source_type),
               title: args.title,
               url: args.url))
    end

    desc "Delete source by its id"
    task :delete, [:id] => :environment do |_t, args|
      Print.(Source.destroy(args.fetch(:id)))
    end

    desc 'Fetch source'
    task :fetch, [:id] => :environment do |_t, args|
      id = args.fetch(:id)
      Print.(FetchJobOffersWorker.perform_async(id))
      puts "Scheduled source #{id}"
    end
  end

  namespace :feed do
    desc "Add feed"
    task :add, [:title] => :environment do |_t, args|
      Print.(Feed.create!(title: args.title))
    end

    desc "Delete feed by its id"
    task :delete, [:id] => :environment do |_t, args|
      Print.(Feed.destroy(args.fetch(:id)))
    end
  end

  namespace :feed_source_mapping do
    desc "Map source to feed"
    task :add, [:feed_id, :source_id] => :environment do |_t, args|
      Print.(FeedSource.create!(feed_id: args.fetch(:feed_id),
                                source_id: args.fetch(:source_id)))
    end

    desc "Delete feed source mapping"
    task :delete, [:id] => :environment do |_t, args|
      Print.(FeedSource.destroy(args.fetch(:id)))
    end
  end
end
