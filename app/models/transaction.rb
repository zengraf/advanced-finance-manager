class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :area
  belongs_to :account
  belongs_to :destination_account, class_name: 'Account', foreign_key: 'destination_account_id', optional: true
  has_one :loan, inverse_of: :exchanges

  scope :months, ->(first, last = nil) {
    where('date > ? AND date < ?', first, (last || first.end_of_month))
  }

  before_save :alter_account_amount

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

  private

  def alter_account_amount
    Account.transaction do
      account.update(amount: account.amount + (amount - (amount_was || 0)))
      destination_account.update(amount: destination_account.amount + destination_amount) if destination_account && destination_amount
    end
  end
end
