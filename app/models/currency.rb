class Currency < ApplicationRecord
  has_and_belongs_to_many :users

  scope :not_belonging_to, ->(user) { where.not(id: user.currencies.select(:id)) }

  def attributes
    {
      id: 0,
      name: "",
      code: "",
      number: 0
    }
  end
end
