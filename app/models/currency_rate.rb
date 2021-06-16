class CurrencyRate < ApplicationRecord
  belongs_to :from, class_name: 'Currency', foreign_key: 'from_id'
  belongs_to :to, class_name: 'Currency', foreign_key: 'to_id'

  def attributes
    {
      from: "",
      to: "",
      source: "",
      rate: 0
    }
  end
end
