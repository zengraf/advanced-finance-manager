class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Rails.application.routes.url_helpers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_and_belongs_to_many :currencies, -> { distinct }
  has_many :accounts
  has_many :transactions, through: :accounts
  has_many :areas
  has_many :categories
  has_many :loans

  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true

  def attributes
    {
      username: nil,
      email: '',
      avatar_url: nil
    }
  end

  def avatar_url
    return nil unless avatar.attached?

    rails_blob_url(avatar)
  end
end
