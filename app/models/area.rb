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

  def total_for_categories(from, to = nil)
    transactions.months(from, to).group(:category).sum(:amount)
  end

  def total_for_area(from, to)
    transactions.months(from, to).sum(:amount)
  end
end
