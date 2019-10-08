module QuestionsHelper
  QUESTION_HEADERS = {
    new: ->(title) { "Create New #{title} Question" },
    edit: ->(title) { "Edit #{title} Question" }
  }

  def question_header
    QUESTION_HEADERS[action_name.to_sym].call(@question.test.title)
  end
end
