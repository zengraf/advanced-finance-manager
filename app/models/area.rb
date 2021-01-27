class Area < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :categories, through: :transactions
end
