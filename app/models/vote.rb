class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :interaction, polymorphic: true

  validates :user_id, presence: true
  validates :user_id, :uniqueness => { :scope => [:interaction_type, :interaction_id] }
  validates :interaction, presence: true

end
