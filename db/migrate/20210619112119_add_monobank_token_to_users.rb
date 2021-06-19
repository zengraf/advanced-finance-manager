class AddMonobankTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :monobank_token, :string
  end
end
