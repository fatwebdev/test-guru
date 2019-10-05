class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: :User

  has_many :questions
  has_many :passing_tests
  has_many :users, through: :passing_tests

  def self.sorted_desc_by_category_title(title)
    Test
      .joins(:category)
      .where(categories: { title: title })
      .order(id: :desc)
      .pluck('tests.title')
  end
end
