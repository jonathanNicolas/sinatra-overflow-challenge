class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :title
      t.string :text

      t.timestamps(null: false)
    end
  end
end
