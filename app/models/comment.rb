class Comment < ActiveRecord::Base
  belongs_to :response, polymorphic: true
  belongs_to :user
  has_many :votes, as: :interaction

end
