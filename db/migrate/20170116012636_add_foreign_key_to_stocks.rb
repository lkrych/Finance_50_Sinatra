class AddForeignKeyToStocks < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :stocks, :users
  end
end
