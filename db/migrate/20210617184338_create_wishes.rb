class CreateWishes < ActiveRecord::Migration[6.1]
  def change
    create_table :wishes do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 20, scale: 2
      t.references :currency, null: false, foreign_key: true
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end
