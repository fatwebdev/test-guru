class Answer < ApplicationRecord
  validates :body, presence: true
  validate :validate_max_answers, on: :create

  belongs_to :question

  scope :correct, -> { where(correct: true) }

  private

  def validate_max_answers
    errors.add(:base, 'Question can have max 3 answers') if question.answers.count > 3
  end
end
