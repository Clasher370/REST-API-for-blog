class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates_presence_of :title, :body

  def author_nickname
    author.nickname
  end
end
