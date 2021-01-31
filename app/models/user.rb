class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :currencies
  has_many :accounts
  has_many :transactions, through: :accounts
  has_many :areas
  has_many :categories
  has_many :loans
end
