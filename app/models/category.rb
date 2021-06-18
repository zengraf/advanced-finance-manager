class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions

  def attributes
    {
      id: 0,
      name: "",
      limit: nil,
    }
  end

end
