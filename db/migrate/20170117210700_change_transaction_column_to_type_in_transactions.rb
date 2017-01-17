class ChangeTransactionColumnToTypeInTransactions < ActiveRecord::Migration[5.0]
  def change
    rename_column :transactions, :transaction, :type
  end
end
