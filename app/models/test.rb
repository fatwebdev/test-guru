class Test < ApplicationRecord
  belongs_to :category

  has_many :passing_tests
  has_many :users, through: :passing_tests
end
