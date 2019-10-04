class Test < ApplicationRecord
  belongs_to :category

  has_many :passing_tests
  has_many :users, through: :passing_tests

  def self.sorted_desc_by_category_title(title)
    Test
      .joins(:category)
      .order(id: :desc)
      .where('categories.title = ?', title)
      .pluck('tests.title')
  end
end
