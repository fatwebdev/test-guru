class AddEmailToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string
    add_index :users, :email, unique: true
    change_column_null :users, :email, false
  end
end
