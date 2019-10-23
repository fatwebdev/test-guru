class Badge < ApplicationRecord
  validates :title, :image, :rule_type, :rule_param, presence: true
end
