class User < ApplicationRecord
  has_many :passing_tests
  has_many :tests, through: :passing_tests
end
