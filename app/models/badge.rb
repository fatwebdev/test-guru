class Badge < ApplicationRecord
  validates :title, :image, :rule_type, :rule_param, presence: true

  has_many :badge_users
  has_many :users, through: :badge_users
end
