class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self


  has_and_belongs_to_many :currencies, -> { distinct }
  has_many :accounts
  has_many :transactions, through: :accounts
  has_many :areas
  has_many :categories
  has_many :loans
end
