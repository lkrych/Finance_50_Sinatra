class AddUserForeignKeyToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :transactions, :users
  end
end
