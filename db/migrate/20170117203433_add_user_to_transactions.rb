class AddUserToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :user, :string
  end
end
