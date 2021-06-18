class AddLimitToCategoriesAndAreas < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :limit, :decimal, precision: 20, scale: 2
    add_column :areas, :limit, :decimal, precision: 20, scale: 2
  end
end
