class User < ActiveRecord::Base

  has_many :questions
  has_many :comments
  has_many :votes
  has_many :answers

  validates :name, presence: true
  validates :github_username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :github_username, presence: true, uniqueness: true

end
