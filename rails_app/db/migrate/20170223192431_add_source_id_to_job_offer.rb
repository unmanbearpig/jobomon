class AddSourceIdToJobOffer < ActiveRecord::Migration[5.0]
  def change
    add_reference :job_offers, :source, foreign_key: true
  end
end
