class CreateTrustedContacts < ActiveRecord::Migration[8.1]
  def change
    create_table :trusted_contacts do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.boolean :share_mood, null: false, default: false

      t.timestamps
    end
  end
end
