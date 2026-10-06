class CreateMoodEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :mood_entries do |t|
      t.references :profile, null: false, foreign_key: true
      t.date :entry_date
      t.integer :mood_level
      t.integer :energy_level
      t.decimal :sleep_hours, precision: 4, scale: 1
      t.string :emotions
      t.text :note

      t.timestamps
    end
      add_index :mood_entries, [ :profile_id, :entry_date ], unique: true
end
end
