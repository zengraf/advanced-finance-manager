class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.decimal :interest, precision: 10, scale: 6
      t.timestamp :deadline
      t.boolean :active

      t.timestamps
    end
  end
end
