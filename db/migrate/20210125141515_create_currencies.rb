class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.integer :number, null: false

      t.timestamps
    end
  end
end
