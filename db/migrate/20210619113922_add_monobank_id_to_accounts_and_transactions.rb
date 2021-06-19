class AddMonobankIdToAccountsAndTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :monobank_id, :string
    add_column :accounts, :monobank_id, :string
  end
end
