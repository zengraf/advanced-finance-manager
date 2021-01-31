class Currency < ApplicationRecord
  has_and_belongs_to_many :users

  scope :not_belonging_to, ->(user) { where.not(id: user.currencies.select(:id)) }
end
