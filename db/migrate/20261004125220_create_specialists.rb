class CreateSpecialists < ActiveRecord::Migration[8.1]
  def change
    create_table :specialists do |t|
      t.string :full_name
      t.string :specialty
      t.references :city, null: false, foreign_key: true
      t.text :contacts
      t.decimal :rating

      t.timestamps
    end
  end
end
