class Loan < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :exchanges, class_name: 'Transaction'
end
