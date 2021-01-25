class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 20, scale: 2
      t.timestamp :date
      t.references :category, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.integer :destination_account_id, foreign_key: true
      t.decimal :destination_amount, precision: 20, scale: 2

      t.timestamps
    end
  end
end
