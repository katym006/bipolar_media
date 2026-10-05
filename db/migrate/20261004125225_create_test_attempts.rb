class CreateTestAttempts < ActiveRecord::Migration[8.1]
  def change
    create_table :test_attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :screening_test, null: false, foreign_key: true
      t.json :answers
      t.integer :score
      t.datetime :completed_at

      t.timestamps
    end
  end
end
