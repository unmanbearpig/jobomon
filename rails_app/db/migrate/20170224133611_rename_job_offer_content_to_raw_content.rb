class RenameJobOfferContentToRawContent < ActiveRecord::Migration[5.0]
  def change
    rename_column :job_offers, :content, :raw_content
  end
end
