class User < ApplicationRecord
  has_many :created_tests, class_name: :Test, foreign_key: :author_id
  has_many :passing_tests
  has_many :tests, through: :passing_tests

  def open_tests_by_level(level)
    tests.where(level: level)
  end
end
