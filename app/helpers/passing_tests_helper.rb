module PassingTestsHelper
  def current_question_number
    @passing_test.test.question_sequence_number(@passing_test.current_question)
  end
end
