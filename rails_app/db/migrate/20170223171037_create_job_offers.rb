class CreateJobOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :job_offers do |t|
      t.string :url, null: false
      t.string :title
      t.text :content
      t.datetime :published_at

      t.timestamps
    end
  end
end
