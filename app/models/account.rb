class Account < ApplicationRecord
  belongs_to :user
  belongs_to :currency
  has_many :transactions
  has_many :categories, through: :transactions
  has_many :areas, through: :transactions

  def attributes
    {
      id: 0,
      name: nil,
      amount: 0,
      currency: nil
    }
  end
end
