class CreateFeedsThatWouldHaveMultipleSources < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.timestamps
    end

    create_table :feed_sources do |t|
      t.references :feed, null: false
      t.references :source, null: false

      t.timestamps
    end
  end
end
