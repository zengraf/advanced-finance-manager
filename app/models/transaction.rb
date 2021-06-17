class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :area
  belongs_to :account
  belongs_to :destination_account, class_name: 'Account', foreign_key: 'destination_account_id', optional: true
  has_one :loan, inverse_of: :exchanges

  scope :months, ->(first, last = nil) {
    where('date > ? AND date < ?', first.beginning_of_month, (last || first).end_of_month)
  }
  scope :with_exchange_rate, ->(currency_id) {
    joins(account: :currency)
      .joins("INNER JOIN currency_rates ON currency_rates.from_id = currencies.id")
      .where("currency_rates.to_id = ?", currency_id)
      .select("transactions.*, currency_rates.rate, currency_rates.to_id")
  }

  after_create :alter_account_amount

  def attributes
    {
      id: 0,
      amount: 0,
      date: Date.today,
      category: nil,
      area: nil,
      account: nil,
      destination_account: nil,
      destination_amount: nil,
      description: nil,
      updated_at: Time.now
    }
  end

  def get_exchange_rate(target_currency_id)
    if target_currency_id == account.currency.id
      return 1
    end
    CurrencyRate.where("from_id = ? AND to_id = ?", account.currency.id, target_currency_id).first.rate
  end

  private

  def alter_account_amount
    Account.transaction do
      account.update(amount: account.amount + amount)
      destination_account.update(amount: destination_account.amount + destination_amount) if destination_account && destination_amount
    end
  end
end
