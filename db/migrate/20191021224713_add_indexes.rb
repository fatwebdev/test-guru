class AddIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index :passing_tests, :current_question_id
  end
end
