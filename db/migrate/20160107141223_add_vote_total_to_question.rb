class AddVoteTotalToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :vote_total, :integer, :default => 0
  end
end
