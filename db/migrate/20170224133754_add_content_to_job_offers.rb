class AddContentToJobOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :job_offers, :content, :text
  end
end
