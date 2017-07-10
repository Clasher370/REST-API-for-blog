class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :published_at, :author_id

  belongs_to :author
end
