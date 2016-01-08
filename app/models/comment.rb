class Comment < ActiveRecord::Base
  belongs_to :response, polymorphic: true
  belongs_to :user
  has_many :votes, as: :interaction

  validates :vote_total, presence: true

  def time_since_creation
    hours_since_creation = ((Time.now - created_at) / 3600).round
    return "less than an hour ago" if hours_since_creation == 0
    time_since = (hours_since_creation / 24).to_s
    if time_since.to_i > 0
      time_since += " day" if time_since.to_i == 1
      time_since += " days" if time_since.to_i > 1
    else
      time_since = hours_since_creation.to_s + " hours"
    end

    return time_since
  end

end
