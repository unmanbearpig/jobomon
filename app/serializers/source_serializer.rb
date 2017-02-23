class SourceSerializer < ActiveModel::Serializer
  attributes :id, :url, :title, :source_type
  has_many :job_offers, if: :include_job_offers?

  def include_job_offers?
    instance_options[:include_job_offers]
  end
end
