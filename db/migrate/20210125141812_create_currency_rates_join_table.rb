class CreateCurrencyRatesJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :currency_rates, id: false do |t|
      t.integer :from_id, null: false, foreign_key: true
      t.integer :to_id, null: false, foreign_key: true
      t.string :source
      t.decimal :rate, null: false, precision: 14, scale: 4
    end

    add_index :currency_rates, %i[from_id to_id]
  end
end
