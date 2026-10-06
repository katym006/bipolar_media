class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :summary
      t.text :body
      t.string :content_kind
      t.string :audience
      t.string :source_url
      t.boolean :expert_reviewed, null: false, default: false
      t.datetime :published_at

      t.timestamps
    end
  end
end
