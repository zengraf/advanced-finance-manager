class Wish < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  def attributes
    {
      id: 0,
      amount: 0,
      description: '',
      url: '',
      currency: nil
    }
  end
end
