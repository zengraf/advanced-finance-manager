class AddPrimaryCurrencyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :primary_currency_id, :bigint, foreign_key: true
    User.includes(:currencies).find_each do |user|
      user.update_column(:primary_currency_id, user.currencies.first&.id || Currency.first.id)
    end
    change_column_null :users, :primary_currency_id, false
  end
end
