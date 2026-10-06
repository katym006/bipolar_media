class CreateTestQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :test_questions do |t|
      t.references :screening_test, null: false, foreign_key: true
      t.text :text
      t.integer :position

      t.timestamps
    end
    add_index :test_questions, [ :screening_test_id, :position ], unique: true
  end
end
