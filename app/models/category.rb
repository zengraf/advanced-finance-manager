class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions

  def attributes
    {
      id: 0,
      name: "",
    }
  end

  def total_for_areas(from, to = nil)
    transactions.months(from, to).group(:area).sum(:amount)
  end

  def total_for_category(from, to)
    transactions.months(from, to).sum(:amount)
  end
end
