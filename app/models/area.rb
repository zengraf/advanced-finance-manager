class Area < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :categories, through: :transactions

  def attributes
    {
      id: 0,
      name: "",
    }
  end

  def total_this_month
    transactions.months(Date.current).sum(:amount)
  end
end
