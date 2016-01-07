class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text, :null => false
      t.references :user, :null => false
      t.references :response, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
