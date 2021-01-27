class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :area
  belongs_to :account
  belongs_to :destination_account, class_name: 'Account', foreign_key: 'destination_account_id'
  has_one :loan
end
