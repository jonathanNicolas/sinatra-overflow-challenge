class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname, :null => false
      t.string :email, :null => false
      t.string :github_username, :null => false
      t.string :github_avatar_url
      t.timestamps null: false
    end
    add_index :users, :email, :unique => true
  end
end
