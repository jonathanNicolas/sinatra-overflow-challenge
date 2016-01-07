class AddVoteTotalToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :vote_total, :integer, :default => 0
  end
end
