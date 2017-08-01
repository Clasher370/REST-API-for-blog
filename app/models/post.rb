class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates_presence_of :title, :body

  before_create :set_published_at

  def set_published_at
    self.published_at = Time.now unless self.published_at
  end

  def author_nickname
    author.nickname
  end
end
