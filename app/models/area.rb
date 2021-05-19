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
end
