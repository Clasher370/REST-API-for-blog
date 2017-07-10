class User < ApplicationRecord
  has_secure_password

  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'

  validates_presence_of :nickname, :email, :password_digest
end
