module PassingTestsHelper
  def current_question_number
    @passing_test.test.question_sequence_number(@passing_test.current_question)
  end

  def progress_bar
    content_tag :div, class: 'progress' do
      content_tag :div, nil,
        class: 'progress-bar',
        role: 'progressbar',
        style: "width: #{percent_of_passing_test}%",
        aria_valuenow: percent_of_passing_test,
        aria_valuemin: 0,
        aria_valuemax: 100
    end
  end

  private

  def percent_of_passing_test
    current_question_number.to_f / @passing_test.test.questions.count * 100
  end
end
