class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :votes
  has_many :comments, as: :response
  has_many :votes, as: :interaction

  validates :text, presence: true

end
