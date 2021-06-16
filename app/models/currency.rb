class Currency < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :purchase_rates, class_name: 'CurrencyRate', foreign_key: "to_id"
  has_many :selling_rates, class_name: 'CurrencyRate', foreign_key: "from_id"

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
