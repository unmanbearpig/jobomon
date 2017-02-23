class SourceSerializer < ActiveModel::Serializer
  attributes :id, :url, :title, :source_type
end
