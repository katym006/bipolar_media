class AddDetailsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :string, null: false, default: "curious"
    add_column :users, :access_role, :string, null: false, default: "reader"
  end
end
