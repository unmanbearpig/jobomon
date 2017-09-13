class AddSourceTypeToSources < ActiveRecord::Migration[5.0]
  def change
    add_column :sources, :source_type, :string, null: false
  end
end
