class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :votes
  has_many :comments

  validates :text, presence: true

end
