class FeedSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :sources, if: :include_sources?
  has_many :job_offers, if: :include_job_offers?

  def include_sources?
    instance_options[:include_sources]
  end

  def include_job_offers?
    instance_options[:include_job_offers]
  end
end
