class AddTitleToFeed < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :title, :string, null: false
  end
end
