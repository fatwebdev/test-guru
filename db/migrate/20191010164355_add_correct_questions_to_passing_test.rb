class AddCorrectQuestionsToPassingTest < ActiveRecord::Migration[6.0]
  def change
    add_column :passing_tests, :correct_questions, :integer, default: 0
  end
end
