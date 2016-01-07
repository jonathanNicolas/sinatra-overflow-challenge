class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :user, :null => false
      t.string :title
      t.string :text

      t.timestamps(null: false)
    end
  end
end
