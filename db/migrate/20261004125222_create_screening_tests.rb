class CreateScreeningTests < ActiveRecord::Migration[8.1]
  def change
    create_table :screening_tests do |t|
      t.string :title
      t.text :description
      t.string :kind

      t.timestamps
    end
  end
end
