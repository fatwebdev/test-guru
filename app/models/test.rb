class Test < ApplicationRecord
  validates :title, presence: true
  validates :level, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }
  validates :title, uniqueness: { scope: :level }

  belongs_to :category
  belongs_to :author, class_name: :User

  has_many :questions, dependent: :destroy
  has_many :passing_tests, dependent: :destroy
  has_many :users, through: :passing_tests

  scope :level, ->(level) { where(level: level) }
  scope :level_easy, -> { level(0..1) }
  scope :level_medium, -> { level(2..4) }
  scope :level_hard, -> { level(5..Float::INFINITY) }
  scope :by_category, lambda { |title|
    Test
      .joins(:category)
      .where(categories: { title: title })
  }

  def self.sorted_desc_by_category_title(title)
    by_category(title)
      .order(id: :desc)
      .pluck('tests.title')
  end

  def question_sequence_number(question)
    questions.order(:id).index(question) + 1
  end

  def next_question_after(question)
    return nil if question.nil?

    questions.order(:id).where('id > ?', question.id).first
  end
end
