class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.decimal :amount, precision: 20, scale: 2
      t.references :currency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
