class JobOfferSerializer < ActiveModel::Serializer
  attributes :id, :url, :title, :content, :published_at
end
