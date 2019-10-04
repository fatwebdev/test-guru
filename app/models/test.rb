class Test < ApplicationRecord
  belongs_to :category

  has_many :passing_tests
  has_many :users, through: :passing_tests

  def self.sorted_desc_by_category_title(title)
    category = Category.find_by(title: title)
    return [] if category.nil?

    Test.order(id: :desc).where(category_id: category.id)
  end
end
