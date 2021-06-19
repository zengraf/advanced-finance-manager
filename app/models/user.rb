class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Rails.application.routes.url_helpers

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  belongs_to :primary_currency, class_name: 'Currency'
  has_and_belongs_to_many :currencies, -> { distinct }
  has_many :accounts
  has_many :transactions, through: :accounts
  has_many :areas
  has_many :categories
  has_many :loans
  has_many :wishes

  has_one_attached :avatar

  before_validation :add_primary_currency
  before_create :add_areas_and_categories

  validates :username, presence: true, uniqueness: true

  after_save :set_webhook, if: :monobank_token_changed?

  def attributes
    {
      username: nil,
      email: '',
      primary_currency: Currency.first,
      avatar_url: nil
    }
  end

  def avatar_url
    return nil unless avatar.attached?

    rails_blob_url(avatar)
  end

  private

  def add_primary_currency
    self.primary_currency ||= Currency.first
    currencies << primary_currency
  end

  def add_areas_and_categories
    categories.build([{ name: "Grocery" }])
    areas.build([{ name: "Life" }])
  end
end
