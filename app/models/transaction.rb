class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :area
  belongs_to :account
  belongs_to :destination_account, class_name: 'Account', foreign_key: 'destination_account_id', optional: true
  has_one :loan

  after_create :alter_account_amount

  private

  def alter_account_amount
    account.increment!(:amount, amount)
  end
end
