class AddCurrentQuestionToPassingTest < ActiveRecord::Migration[6.0]
  def change
    add_column :passing_tests, :current_question_id, :integer
  end
end
