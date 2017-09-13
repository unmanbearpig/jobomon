class AddFetchedAtToSources < ActiveRecord::Migration[5.0]
  def change
    add_column :sources, :fetched_at, :datetime
  end
end
