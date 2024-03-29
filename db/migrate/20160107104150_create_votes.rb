class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, :null => false
      t.references :interaction, polymorphic: true, index: true

      t.timestamps(null:false)
    end
  end
end