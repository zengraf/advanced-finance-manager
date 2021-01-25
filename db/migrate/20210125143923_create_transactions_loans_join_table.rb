class CreateTransactionsLoansJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :transactions, :loans
  end
end
