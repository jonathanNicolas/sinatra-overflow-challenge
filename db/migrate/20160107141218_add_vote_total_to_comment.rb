class AddVoteTotalToComment < ActiveRecord::Migration
  def change
    add_column :comments, :vote_total, :integer, :default => 0
  end
end
