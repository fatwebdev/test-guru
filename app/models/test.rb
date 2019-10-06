class Test < ApplicationRecord
  validates :title, presence: true
  validates :level, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }
  validates :title, uniqueness: { scope: :level }

  belongs_to :category
  belongs_to :author, class_name: :User

  has_many :questions
  has_many :passing_tests
  has_many :users, through: :passing_tests

  scope :level, ->(level) { where(level: level) }
  scope :level_easy, -> { level(0..1) }
  scope :level_medium, -> { level(2..4) }
  scope :level_hard, -> { level(5..Float::INFINITY) }
  scope :by_category, lambda { |title|
    Test
      .joins(:category)
      .where(categories: { title: title })
      .order(id: :desc)
      .pluck('tests.title')
  }
end
