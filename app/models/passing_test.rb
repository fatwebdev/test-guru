class PassingTest < ApplicationRecord
  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: :Question, optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_validation :before_validation_set_next_question, on: :update

  before_update :before_update_test_passed

  scope :correct_passed_tests, ->(user) {
    user.test_passages.where(passed: true)
  }

  MINIMUM_PERCENTAGE = 85

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end

    save!
  end

  def completed?
    current_question.nil?
  end

  def percentage_of_completion
    ((correct_questions.to_f / test.questions.count) * 100).round
  end

  def passed?
    percentage_of_completion >= MINIMUM_PERCENTAGE
  end

  def remainder_time
    expires_at.to_i
  end

  def time_is_over?
    expires_at < Time.now
  end

  def end_passing_test!
    self.current_question = nil

    save!
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def before_validation_set_next_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.next_question_after(current_question)
  end

  def before_update_test_passed
    self.done = passed? if completed?
  end

  def expires_at
    created_at + test.countdown.minutes
  end
end
