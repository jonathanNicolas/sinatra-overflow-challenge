class AddVoteTypeToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :is_upvote, :boolean
  end
end
