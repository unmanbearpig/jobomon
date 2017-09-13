class RenameFeedsToSources < ActiveRecord::Migration[5.0]
  def change
    rename_table :feeds, :sources
  end
end
