class User < ApplicationRecord
  has_many :created_tests, class_name: :Test, foreign_key: :author_id
  has_many :passing_tests
  has_many :tests, through: :passing_tests
end
