module QuestionsHelper
  def question_header_for(action)
    t("admin.questions.#{action}.header", title: @question.test.title)
  end
end