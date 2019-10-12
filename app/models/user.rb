class User < ApplicationRecord
  validates :login, :email, :password, presence: true
  validates :email, uniqueness: true

  has_many :created_tests, class_name: :Test, foreign_key: :author_id
  has_many :passing_tests
  has_many :tests, through: :passing_tests

  def passing_test(test)
    passing_tests.order(id: :desc).find_by(test_id: test.id)
  end
end
