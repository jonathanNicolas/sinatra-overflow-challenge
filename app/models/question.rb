class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :votes, as: :interaction
  has_many :comments, as: :response


  validates :user_id, presence: true
  validates :title, presence: true
  validates :text

end
