class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :area
  belongs_to :account
end
