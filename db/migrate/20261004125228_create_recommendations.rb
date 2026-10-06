class CreateRecommendations < ActiveRecord::Migration[8.1]
  def change
    create_table :recommendations do |t|
      t.references :test_attempt, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.string :reason

      t.timestamps
    end
    add_index :recommendations, [ :test_attempt_id, :article_id ], unique: true
  end
end
