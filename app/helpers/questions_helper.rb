module QuestionsHelper
  QUESTION_HEADERS = {
    new: ->(title) { "Create New #{title} Question" },
    edit: ->(title) { "Edit #{title} Question" }
  }

  def question_header_for(action)
    QUESTION_HEADERS[action].call(@question.test.title)
  end
end
