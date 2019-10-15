class RemoveLoginAttributeFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :login
  end
end
