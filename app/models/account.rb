class Account < ApplicationRecord
  belongs_to :user
  belongs_to :currency
  has_many :transactions
  has_many :categories, through: :transactions
  has_many :areas, through: :transactions
end
