class AddNameAndTypeAttributesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :type, :string, null: false, default: 'User'
    add_column :users, :first_name, :string, null: false, default: ''
    add_column :users, :last_name, :string, null: false, default: ''

    add_index :users, :type
  end
end
