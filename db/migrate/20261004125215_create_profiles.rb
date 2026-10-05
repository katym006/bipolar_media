class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.references :city, null: true, foreign_key: true
      t.boolean :daily_reminder, null: false, default: false
      t.string :display_name
      t.string :avatar
      t.date :birth_date
      t.date :diagnosed_at
      t.time :reminder_time

      t.timestamps
    end
  end
end
