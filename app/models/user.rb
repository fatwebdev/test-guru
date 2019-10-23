class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    :confirmable

  validates :first_name, :last_name, presence: true

  has_many :created_tests, class_name: :Test, foreign_key: :author_id
  has_many :passing_tests
  has_many :tests, through: :passing_tests
  has_many :gists
  has_many :feedbacks

  def passing_test(test)
    passing_tests.order(id: :desc).find_by(test_id: test.id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    is_a?(Admin)
  end
end
